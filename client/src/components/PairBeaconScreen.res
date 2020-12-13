open Belt
open ReactNative

@react.component
let make = () => {
  let (appState, setAppState) = StateProvider.useContext()
  let (beacons, setBeacons) = React.useState(() => [])
  let (selected: option<Beacon.t>, setSelected) = React.useState(() => None)

  // XXX for tests
  React.useEffect0(() => {
    let _ = Js.Global.setTimeout(() => {
      setBeacons(_ => [
        { Beacon.id: "012" },
        { Beacon.id: "345" },
        { Beacon.id: "678" },
        { Beacon.id: "abc" },
      ])
    }, 4000)
    None
  })

  let saveBeacon = beacon => {
    open Async
    Storage.saveBeacon(beacon)
      ->then_(() => setAppState(StateProvider.take(SaveBeacon))->async)
  }

  let confirmSaved = () => setAppState(StateProvider.take(ConfirmBeaconSaved))

  <>
    <View>
      <Text>{"Pairing beacon"->React.string}</Text>
      {
        if appState == StateProvider.ScanningBeacon && selected->Option.isSome {
          <View>
            <Button title="Yes" onPress={_ => selected->Option.map(saveBeacon) |> ignore} />
            <Button title="No" onPress={_ => setSelected(_ => None)} />
          </View>
        } else if appState == StateProvider.BeaconPaired {
          <View>
            <Button title="Proceed" onPress={_ => confirmSaved()} />
          </View>
        } else {
          React.null
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
