
type beacon_data = {
  id : string,
  uid : string,
  rssi : float,
  txPower : float,
};

type url_data = {
  uid : string,
  url : string,
};

type telemetry_data = {
  uid : string,
  voltage : float,
  temp : float,
};

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external startScanning : unit => unit = "startScanning";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external stopScanning : unit => unit = "stopScanning";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external addListener : @bs.string [
  | #onUIDFrame(beacon_data => unit)
  | #onEIDFrame(beacon_data => unit)
  | #onURLFrame(url_data => unit)
  | #onTelemetryFrame(telemetry_data => unit)
  | #onStateChanged(string => unit)
] => unit = "addListener";

@bs.module("@lg2/react-native-eddystone") @bs.scope("default")
external removeListener : @bs.string [
  | #onUIDFrame(beacon_data => unit)
  | #onEIDFrame(beacon_data => unit)
  | #onURLFrame(url_data => unit)
  | #onTelemetryFrame(telemetry_data => unit)
  | #onStateChanged(string => unit)
] => unit = "removeListener";
