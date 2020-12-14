open Belt

type t = { id: string, uid: string, rssi: float, txPower: float }

let fromEddystone = (b: EddyStone.BeaconData.t) => {
  id: b.id,
  uid : b.uid,
  rssi : b.rssi,
  txPower : b.txPower,
}

let toString = (beacon: t) => beacon->Js.Json.stringifyAny->Option.getExn
let fromString = Js.Json.parseExn
