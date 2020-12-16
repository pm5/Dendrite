open Belt
open Async

let saveBeacon = beacon =>
  ReactNativeAsyncStorage.setItem("beacon", beacon->Beacon.toString)

let loadBeacon = () =>
  ReactNativeAsyncStorage.getItem("beacon")
    ->then_(dataOrNull =>
        dataOrNull
          ->Js.Null.toOption
          ->Option.flatMap(Beacon.fromString)
          ->async
      )

let resetBeacon = () =>
  ReactNativeAsyncStorage.setItem("beacon", "")

let saveUser = user =>
  ReactNativeAsyncStorage.setItem("user", user->Citizen.toString)

let loadUser = () =>
  ReactNativeAsyncStorage.getItem("user")
    ->then_(dataOrNull =>
        dataOrNull
          ->Js.Null.toOption
          ->Option.flatMap(Citizen.fromString)
          ->async
      )

let resetUser = () =>
  ReactNativeAsyncStorage.setItem("user", "")
