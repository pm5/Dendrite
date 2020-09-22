
module BeaconData = {
  type t = {
    id : string,
    uid : string,
    rssi : float,
    txPower : float,
  }
}

module UrlData = {
  type t = {
    uid : string,
    url : string,
  }
}

module TelemetryData = {
  type t = {
    uid : string,
    voltage : float,
    temp : float,
  }
}

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external startScanning : unit => unit = "startScanning";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external stopScanning : unit => unit = "stopScanning";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external addListener : @bs.string [
  | #onUIDFrame(BeaconData.t => unit)
  | #onEIDFrame(BeaconData.t => unit)
  | #onURLFrame(UrlData.t => unit)
  | #onTelemetryFrame(TelemetryData.t => unit)
  | #onStateChanged(string => unit)
] => unit = "addListener";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external removeListener : @bs.string [
  | #onUIDFrame(BeaconData.t => unit)
  | #onEIDFrame(BeaconData.t => unit)
  | #onURLFrame(UrlData.t => unit)
  | #onTelemetryFrame(TelemetryData.t => unit)
  | #onStateChanged(string => unit)
] => unit = "removeListener";
