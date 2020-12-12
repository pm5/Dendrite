
type t =
  | Start

  | ScanningBeacon
  | BeaconPaired
  | BeaconUnpaired

  | NoUserStored
  | DownloadingUser
  | ErrorUserNotFound
  | ErrorUserInvalid
  | UserJustStored

  | Initializing
  | Monitoring
  | NearbyUserDetected
  | QueryingUser
  | WarningUser

type action =
  | PairBeacon
  | SaveBeacon
  | ConfirmBeaconSaved

let next = (action, currentState) =>
  switch (action, currentState) {
    | (PairBeacon, Start) => ScanningBeacon
    | (SaveBeacon, ScanningBeacon) => BeaconPaired
    | (ConfirmBeaconSaved, BeaconPaired) => Start
    | _ => failwith("Invalid action at current state")
  }
