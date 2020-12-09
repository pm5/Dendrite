
type t =
  | Start

  | NoBeaconPaired
  | BeaconDetected
  | BeaconJustPaired
  | BeaconJustUnpaired

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
