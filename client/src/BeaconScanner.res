let useScanner = () => {
  let (scanning, setScanning) = React.useState(() => false)
  let data : EddyStone.BeaconData.t =
    { id: "0"
    , uid : "0x00"
    , rssi : 0.1
    , txPower : 0.01,
    }
  let (beacons, setBeacons) = React.useState(() => { "beacons": [
    data
  ] })

  let beaconListener = (d) => {
    setBeacons(beacons => {
      "beacons": beacons["beacons"]->Js.Array.concat([ d ])->Js.Array.slice(~start=0, ~end_=10)
    })
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
