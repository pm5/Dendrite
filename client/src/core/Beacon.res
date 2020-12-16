open Belt

@decco
type t = {
  distance: float,
  major: int,
  minor: int,
  proximity: string,
  rssi: int,
  uuid: string,
}

let toString = beacon => beacon->Js.Json.stringifyAny->Option.getExn
let fromString = str =>
  switch (str->Js.Json.parseExn->t_decode) {
    | Ok(beacon) => Some(beacon)
    | Error(_) => None
  }
let toCitizenId = beacon => beacon.minor->Int.toString
