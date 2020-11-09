Dotenv.config()

open Belt

@bs.module("fs")
external readFileSync : string => string => string = "readFileSync"

let db = Db.Airtable.make(
  ~endpoint=Node.Process.process["env"]->Js.Dict.get("AIRTABLE_ENDPOINT")->Option.getExn,
  ~api_key=Node.Process.process["env"]->Js.Dict.get("AIRTABLE_KEY")->Option.getExn,
)

let schema = readFileSync("schema.graphql", "utf-8")

let resolvers = {
  GraphQL.Resolvers.query: {
    allCitizens: (_, _, _, _) => Db.citizens(db, ()),
    allPathogens: (_, _, _, _) => Db.pathogens(db),
    allVaccines: (_, _, _, _) => Db.vaccines(db),
    allAntibodies: (_, _, _, _) => Db.antibodies(db),
    citizen: (_, args, _, _) => {
      open Js.Promise
      let id = args->Js.Dict.get("id")->Option.getExn
      Db.citizens(db, ~filter="id%3D'" ++ id ++ "'", ())
      |>then_(data => Array.getExn(data, 0) |> resolve)
    },
  },
  vaccine: {
    generates: o => Db.antibody_of(db, o.generates),
  },
  antibody: {
    bindsTo: o => o.bindsTo->Array.map(Db.pathogen_of(db))->Js.Promise.all,
  },
  infection: {
    pathogen: o => Db.pathogen_of(db, o.pathogen),
  },
  vaccination: {
    vaccine: o => Db.vaccine_of(db, o.vaccine),
  },
  immunity: {
    antibody: o => Db.antibody_of(db, o.antibody),
  },
  citizen: {
    infections: o => o.infections->Array.map(Db.infection_of(db))->Js.Promise.all,
    vaccinations: o => o.vaccinations->Array.map(Db.vaccination_of(db))->Js.Promise.all,
    immunities: o => o.immunities->Array.map(Db.immunity_of(db))->Js.Promise.all,
  }
}

module AppServer = ApolloServer.Make(GraphQL.Resolvers)

let server = AppServer.createApolloServer(~typeDefs=AppServer.gql(schema), ~resolvers=resolvers, ())

{
  open Js.Promise
  server->AppServer.listen({ AppServer.port: 80 })
    |> then_(() => Js.log("server start") |> resolve)
}
