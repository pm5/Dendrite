type t =
  | Start
  | BeaconPaired(Beacon.t)
  | UserLoaded(Beacon.t, Citizen.t)

  | ScanningBeacon
  | BeaconSaved(Beacon.t)

  | LoadingUser(Beacon.t)

  | Monitoring(Beacon.t, Citizen.t)
  | WarningUser(Beacon.t, Citizen.t, Neighbor.t, Pathogen.t)

type action =
  | PairBeacon
  | SaveBeacon(Beacon.t)
  | ConfirmBeaconSaved
  | LoadUser
  | SaveUser(Citizen.t)
  | StartMonitor
  | WarnUser(Neighbor.t, Pathogen.t)

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
    | (SaveBeacon(beacon), ScanningBeacon) => BeaconSaved(beacon)
    | (ConfirmBeaconSaved, BeaconSaved(beacon)) => BeaconPaired(beacon)
    | (LoadUser, BeaconPaired(beacon)) => LoadingUser(beacon)
    | (SaveUser(user), LoadingUser(beacon)) => UserLoaded(beacon, user)
    | (StartMonitor, UserLoaded(beacon, user)) => Monitoring(beacon, user)
    | (WarnUser(neighbor, pathogen), Monitoring(beacon, user)) => WarningUser(beacon, user, neighbor, pathogen)
    | _ => failwith("Invalid action at current state")
  }
