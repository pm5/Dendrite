open Belt
open ReactNative

@react.component
let make = () => {
  let (appState, setAppState) = StateProvider.useContext()
  let (beacons, scanning, setScanning) = BeaconScanner.useScanner()
  let (selected: option<Beacon.t>, setSelected) = React.useState(() => None)

  let saveBeacon = beacon => {
    open Async
    Storage.saveBeacon(beacon)
      ->then_(() => setAppState(StateProvider.take(SaveBeacon(beacon)))->async)
  }

  let confirmSaved = () => setAppState(StateProvider.take(ConfirmBeaconSaved))

  React.useEffect0(() => {
    setScanning(_ => true)
    Some(() => setScanning(_ => false) |> ignore)
  })

  <>
    <View>
      <Text>{(scanning ? "Pairing beacon" : "Not scanning")->React.string}</Text>
      {
        switch appState {
          | StateProvider.ScanningBeacon when selected->Option.isSome => {
            <View>
              <Text>{("Going to pair with " ++ selected->Option.map(beacon => beacon.id)->Option.getWithDefault(""))->React.string}</Text>
              <Button title="Yes" onPress={_ => selected->Option.map(saveBeacon) |> ignore} />
              <Button title="No" onPress={_ => setSelected(_ => None)} />
            </View>
          }
          | StateProvider.BeaconSaved(beacon) => {
            <View>
              <Text>{("Paired with " ++ beacon.id)->React.string}</Text>
              <Button title="Proceed" onPress={_ => confirmSaved()} />
            </View>
          }
          | _ => React.null
        }
      }
      <FlatList
        data=beacons
        renderItem={({ VirtualizedList.item, _ }) =>
            <View key=item.id>
              <Text key=item.id>{ item.id->React.string }</Text>
              <Button
                title="Select"
                onPress={_ => setSelected(_ => Some(item))}
                />
            </View>
        }
        keyExtractor={(beacon, _) => beacon.id}
        />
    </View>
  </>
}
