open ReactNative

@react.component
let make = () => {
  let (beacons, scanning, setScanning) = BeaconScanner.useScanner()

  <View>
    <BeaconList data={beacons} />
    <Button
      onPress={ _ => setScanning(s => !s) }
      title={ (if scanning { "Stop" } else { "Start" }) }
      />
  </View>
}
