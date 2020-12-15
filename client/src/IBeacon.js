import React, { useState } from 'react'
import { DeviceEventEmitter } from 'react-native'
import Beacons from 'react-native-beacons-manager'

export function useScanner() {
  let [beacons, setBeacons] = useState(() => [])
  let [scanning, setScanning] = useState(() => false)
  let region = {
    identifier: "Dendrite",
    uuid: "d8881546-3ebd-11eb-a043-1f17d6b26b6b",
  }

  let updateBeacons = (data) => {
    console.log(data)
    setBeacons(() => data.beacons)
  }

  React.useEffect(() => {
    if (scanning) {
      DeviceEventEmitter.addListener('beaconsDidRange', updateBeacons)
      Beacons.detectIBeacons()
        .then(() => Beacons.startRangingBeaconsInRegion(region))
        .then(() => console.log(`Beacons ranging started succesfully!`))
        .catch(e => console.error(`Beacons ranging not started, error: ${error}`))
    }

    return () => {
      DeviceEventEmitter.removeListener('beaconsDidRange', updateBeacons)
      return Beacons.stopRangingBeaconsInRegion(region)
        .then(() => console.log(`Beacons ranging stopped succesfully!`))
        .then(() => Beacons.removeIBeaconsDetection())
        .catch(e => console.error(`Beacons ranging not stopped, error: ${e}`))
    }
  }, [scanning])

  return [beacons, scanning, setScanning]
}
