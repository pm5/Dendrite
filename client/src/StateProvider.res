type t =
  | NeedPermission
  | Start
  | BeaconPaired(Beacon.t)
  | UserLoaded(Beacon.t, Citizen.t)

  | ScanningBeacon
  | BeaconSaved(Beacon.t)

  | LoadingUser(Beacon.t)

  | Monitoring(Beacon.t, Citizen.t)

type action =
  | PairBeacon
  | SaveBeacon(Beacon.t)
  | ConfirmBeaconSaved
  | LoadUser
  | SaveUser(Citizen.t)
  | StartMonitor

let stateContext = React.createContext((Start, (_: t => t) => ()))

/// XXX include doesn't work?
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
    | (StartMonitor, Monitoring(beacon, user)) => Monitoring(beacon, user)
    | (LoadUser, Monitoring(beacon, _user)) => LoadingUser(beacon)
    | _ => Start
  }
