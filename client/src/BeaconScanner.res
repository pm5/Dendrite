let useScanner = () => {
  let (scanning, setScanning) = React.useState(() => false)
  let (beacons: array<Beacon.t>, setBeacons) = React.useState(() => [])

  let beaconListener = (d) => {
    setBeacons(beacons =>
      beacons->Js.Array.concat([ d->Beacon.fromEddystone ])->Js.Array.slice(~start=0, ~end_=10)
    )
  }

  React.useEffect1(() => {
    EddyStone.addListener(#onUIDFrame(beaconListener))
    EddyStone.startScanning()
    Some(() => {
      EddyStone.stopScanning()
      EddyStone.removeListener(#onUIDFrame(beaconListener))
    })
  }, [ scanning ])

  (beacons, scanning, setScanning)
}
