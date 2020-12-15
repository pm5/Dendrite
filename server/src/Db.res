%%raw(`require('isomorphic-fetch')`)

open Belt

module Airtable = {
  type t = {
    endpoint : string,
    api_key : string,
  }

  let make = (~endpoint, ~api_key) => { endpoint, api_key }

  let table_url = (airtable, table, ~filter=?, ()) =>
    airtable.endpoint ++ "/" ++ table ++ (switch filter {
      | Some(filter) => "?filterByFormula=" ++ filter
      | None => ""
    })

  let record_url = (airtable, table, record) => airtable.endpoint ++ "/" ++ table ++ "/" ++ record
}

let headers = (airtable) => {
  Fetch.RequestInit.make(~headers=Fetch.HeadersInit.make(
    { "Authorization": "Bearer " ++ airtable.Airtable.api_key }), ()
  )
}

module Decode = {
  open Json.Decode

  let pathogen = field("fields", json => {
    GraphQL.Pathogen.name:  json |> field("name", string),
    version:                json |> field("version", string),
    spreadDistanceInMeters: json |> field("spreadDistanceInMeters", Json.Decode.float),
    spreadTimeInSeconds:    json |> field("spreadTimeInSeconds", Json.Decode.float),
    spreadRatio:            json |> field("spreadRatio", Json.Decode.float),
  })

  let pathogens = field("records", array(pathogen))

  let vaccine = field("fields", json => {
    GraphQL.Vaccine.name:  json |> field("name", string),
    version:               json |> field("version", string),
    generates:             (json |> field("generates", array(string)))->Array.getExn(0),
    effectiveAfterSeconds: json |> field("effectiveAfterSeconds", Json.Decode.float),
  })

  let vaccines = field("records", array(vaccine))

  let antibody = field("fields", json => {
    GraphQL.Antibody.name: json |> field("name", string),
    version:               json |> field("version", string),
    bindsTo:               json |> field("bindsTo", array(string))
    expiresInSeconds:      json |> field("expiresInSeconds", Json.Decode.float),
  })

  let antibodies = field("records", array(antibody))

  let citizen = field("fields", json => {
    GraphQL.Citizen.id: json |> field("id", string),
    name:               json |> withDefault("", field("name", string)),
    infections:         json |> withDefault([], field("infections", array(string))),
    vaccinations:       json |> withDefault([], field("vaccinations", array(string))),
    immunities:         json |> withDefault([], field("immunities", array(string))),
  })

  let citizens = field("records", array(citizen))

  let infection = field("fields", json => {
    GraphQL.Infection.pathogen: (json |> field("pathogen", array(string)))->Array.getExn(0),
    infectedAt:                 json |> field("infectedAt", date),
  })

  let vaccination = field("fields", json => {
    GraphQL.Vaccination.vaccine: (json |> field("vaccine", array(string)))->Array.getExn(0),
    adminedAt:                   json |> field("adminedAt", date),
  })

  let immunity = field("fields", json => {
    GraphQL.Immunity.antibody: (json |> field("antibody", array(string)))->Array.getExn(0),
    expiresAt:                 json |> field("expiresAt", date),
  })
}

let records = (db, table, decoder, ~filter=?, ()) => {
  open Js.Promise
  Fetch.fetchWithInit(
    Airtable.table_url(db, table, ~filter=?filter, ()), headers(db)
  )
  |> then_(Fetch.Response.json)
  |> then_(json => json |> decoder |> resolve)
}

let record = (db, table, record, decoder) => {
  open Js.Promise
  Fetch.fetchWithInit(
    Airtable.record_url(db, table, record), headers(db)
  )
  |> then_(Fetch.Response.json)
  |> then_(json => json |> decoder |> resolve)
}

let pathogens = db => records(db, "Pathogen", Decode.pathogens, ())
let pathogen_of = (db, id) => record(db, "Pathogen", id, Decode.pathogen)
let vaccines = db => records(db, "Vaccine", Decode.vaccines, ())
let vaccine_of = (db, id) => record(db, "Vaccine", id, Decode.vaccine)
let antibodies = db => records(db, "Antibody", Decode.antibodies, ())
let antibody_of = (db, id) => record(db, "Antibody", id, Decode.antibody)
let citizens = (db, ~filter=?, ()) => records(db, "Citizen", Decode.citizens, ~filter=?filter, ())
let citizen_of = (db, id) => record(db, "Citizen", id, Decode.citizen)
let infection_of = (db, id) => record(db, "Infection", id, Decode.infection)
let vaccination_of = (db, id) => record(db, "Vaccination", id, Decode.vaccination)
let immunity_of = (db, id) => record(db, "Immunity", id, Decode.immunity)
