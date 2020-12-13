type t =
  | Start

  | ScanningBeacon
  | BeaconPaired(Beacon.t)
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
  | SaveBeacon(Beacon.t)
  | ConfirmBeaconSaved

let stateContext = React.createContext((Start, (_: t => t) => ()))

/// XXX
let makeProps = (~value, ~children, ()) => {
  "value": value,
  "children": children,
}
let make = React.Context.provider(stateContext)
let useContext = () => React.useContext(stateContext)

/** [take action currentState] is the next app state. */
let take = (action, currentState) =>
  switch (action, currentState) {
    | (PairBeacon, Start) => ScanningBeacon
    | (SaveBeacon(beacon), ScanningBeacon) => BeaconPaired(beacon)
    | (ConfirmBeaconSaved, BeaconPaired(_)) => Start
    | _ => failwith("Invalid action at current state")
  }
