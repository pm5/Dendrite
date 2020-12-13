open Belt
open Async

let saveBeacon = beacon =>
  ReactNativeAsyncStorage.setItem("beacon_id", beacon.Beacon.id)

let loadBeacon = () =>
  ReactNativeAsyncStorage.getItem("beacon_id")
    ->then_(idOrNull =>
        idOrNull->Js.Null.toOption->Option.map(id => { Beacon.id: id })->async
      )

let saveUser = user =>
  ReactNativeAsyncStorage.setItem("user_id", user.Citizen.id)
let loadUser = () =>
  ReactNativeAsyncStorage.getItem("user_id")
    ->then_(idOrNull =>
        idOrNull->Js.Null.toOption->Option.map(id => { Citizen.id: id })->async
      )
