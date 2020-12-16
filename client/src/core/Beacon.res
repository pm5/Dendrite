open Belt

type t = {
  distance: float,
  major: int,
  minor: int,
  proximity: string,
  rssi: int,
  uuid: string,
}

let toString = beacon => beacon->Js.Json.stringifyAny->Option.getExn
let fromString = Js.Json.parseExn
let toCitizenId = beacon => beacon.minor->Int.toString
