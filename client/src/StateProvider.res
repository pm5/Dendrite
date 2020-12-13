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
    | (SaveBeacon, ScanningBeacon) => BeaconPaired
    | (ConfirmBeaconSaved, BeaconPaired) => Start
    | _ => failwith("Invalid action at current state")
  }
