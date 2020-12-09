open ReactNative

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
    Js.log("wooty")
    setBeacons(beacons => {
      "beacons": beacons["beacons"]->Js.Array.concat([ d ])->Js.Array.slice(~start=0, ~end_=10)
    })
  }

  React.useEffect1(() => {
    Js.log("woot")
    EddyStone.addListener(#onUIDFrame(beaconListener))
    EddyStone.startScanning()
    Some(() => {
      EddyStone.stopScanning()
      EddyStone.removeListener(#onUIDFrame(beaconListener))
      Js.log("uoot")
    })
  }, [ scanning ])

  (beacons, scanning, setScanning)
}

@react.component
let make = () => {
  let (beacons, scanning, setScanning) = useScanner()

  <View>
    <BeaconList data={beacons["beacons"]} />
    <Button
      onPress={ _ => setScanning(s => !s) }
      title={ (if scanning { "Stop" } else { "Start" }) }
      />
  </View>
}
