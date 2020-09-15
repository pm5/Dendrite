@bs.module("fs")
external readFileSync : string => string => string = "readFileSync"

let pathogens = [
  { GraphQL.Pathogen.id: "0"
  , name: "foo"
  , version: "1.0.0"
  , spreadDistanceInMeters: 1.0
  , spreadTimeInSeconds: 30.0
  , spreadRatio: 0.3
  }
]

let pathogen_of = (.id) => pathogens->Belt.Array.getByU((.p) => p.id == id)

let vaccines = [
  { GraphQL.Vaccine.id: "0"
  , name: "fooForbid"
  , version: "1.0.1"
  , generates: "0"
  , effectiveAfterSeconds: 600.0
  }
]

let vaccine_of = (.id) => vaccines->Belt.Array.getByU((.p) => p.id == id)

let antibodies = [
  { GraphQL.Antibody.id: "0"
  , name: "antifoo"
  , version: "0.8.0"
  , bindsTo: ["0"]
  , expiresInSeconds: 120.0
  }
]

let antibody_of = (.id) => antibodies->Belt.Array.getByU((.p) => p.id == id)

let citizens = [
  { GraphQL.Citizen.id: "0"
  , infections: [
    { pathogen: "0", infectedAt: Js.Date.fromString("2020-09-01T00:00:01") }
    ]
  , vaccinations: [
    { vaccine: "0"
    , adminedAt: Js.Date.make()
    }
    ]
  , immunities: [
    { antibody: "0"
    , expiresAt: Js.Date.fromString("2020-10-01T00:00:01")
    }
    ]
  }
]

let citizen_of = (.id) => citizens->Belt.Array.getByU((.p) => p.id == id)

let schema = readFileSync("schema.graphql", "utf-8")

let resolvers = {
  GraphQL.Resolvers.query: {
    allCitizens: (_, _, _, _) => citizens,
    allPathogens: (_, _, _, _) => pathogens,
    allVaccines: (_, _, _, _) => vaccines,
    allAntibodies: (_, _, _, _) => antibodies,
    citizen: (_, args, _, _) => args->Js.Dict.get("id")->Belt.Option.flatMapU(citizen_of),
  },
  vaccine: {
    generates: o => antibody_of(.o.generates) |> Belt.Option.getExn,
  },
  antibody: {
    bindsTo: o => o.bindsTo->Belt.Array.keepMapU(pathogen_of),
  },
  infection: {
    pathogen: o => pathogen_of(.o.pathogen) |> Belt.Option.getExn,
  },
  vaccination: {
    vaccine: o => vaccine_of(.o.vaccine) |> Belt.Option.getExn,
  },
  immunity: {
    antibody: o => antibody_of(.o.antibody) |> Belt.Option.getExn,
  },
  citizen: {
    infections: o => o.infections,
    vaccinations: o => o.vaccinations,
    immunities: o => o.immunities,
  }
}

module AppServer = ApolloServer.Make(GraphQL.Resolvers)

let server = AppServer.createApolloServer(~typeDefs=AppServer.gql(schema), ~resolvers=resolvers, ())

{
  open Js.Promise
  server->AppServer.listen({ AppServer.port: 8000 })
    |> then_(() => Js.log("http://localhost:8000/") |> resolve)
}
