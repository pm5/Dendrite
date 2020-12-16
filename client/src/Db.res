open Belt

let endpoint = "https://uitc.pominwu.org/"

let postQuery = (~query) =>
  Fetch.fetchWithInit(
    endpoint,
    Fetch.RequestInit.make(
      ~method_=Post,
      ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
      ~body=Fetch.BodyInit.make(query), ()))

let citizen = id => {
  open Async
  postQuery(~query=Citizen.one(id))
  ->then_(Fetch.Response.json)
  ->then_(json => Citizen.one_result_decode(json)->Result.getExn->async)
  ->then_(data => data.data.citizen->async)
}

let allCitizens = () => {
  open Async
  postQuery(~query=Citizen.all())
  ->then_(Fetch.Response.json)
  ->then_(json => Citizen.all_result_decode(json)->Result.getExn->async)
  ->then_(data => data.data.allCitizens->async)
}
