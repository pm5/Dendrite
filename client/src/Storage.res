open Belt
open Async

let saveBeacon = beacon =>
  ReactNativeAsyncStorage.setItem("beacon", beacon->Beacon.toString)

let loadBeacon = () =>
  ReactNativeAsyncStorage.getItem("beacon")
    ->then_(idOrNull =>
        idOrNull->Js.Null.toOption->Option.map(Beacon.fromString)->async
      )

let saveUser = user =>
  ReactNativeAsyncStorage.setItem("user", user->Citizen.to_string)
let loadUser = () =>
  ReactNativeAsyncStorage.getItem("user")
    ->then_(idOrNull =>
        idOrNull->Js.Null.toOption->Option.map(Citizen.from_string)->async
      )
