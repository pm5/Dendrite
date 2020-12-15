open Belt

let endpoint = "https://uitc.pominwu.org/"
let citizen = id => {
  open Async
  Fetch.fetchWithInit(
    endpoint,
    Fetch.RequestInit.make(
      ~method_=Post,
      ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
      ~body=Fetch.BodyInit.make(Citizen.one(id)), ()))
  ->then_(Fetch.Response.json)
  ->then_(json => Citizen.one_result_decode(json)->Result.getExn->async)
}
let allCitizens = () => []

