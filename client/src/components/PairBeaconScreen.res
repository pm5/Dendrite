open Belt
open ReactNative
open Style

let styles = StyleSheet.create({
  "row": style(
    ~flexDirection=#row,
    ~padding=8.->dp,
    ()),
  "beacon": textStyle(
    ~flex=5.,
    ()),
})

module BeaconRow = {
  @react.component
  let make = (~beacon: Beacon.t, ~onSelect) => {
    <View key={beacon.minor->Int.toString} style={styles["row"]}>
      <Text style={Style.array([ScreenStyle.styles["text"], styles["beacon"]])}>{
        `Found ${beacon.minor->Int.toString}`->React.string }</Text>
      <Button
        title="Pair"
        onPress={onSelect}
        />
      </View>
  }
}

@react.component
let make = () => {
  let (appState, setAppState) = StateProvider.useContext()
  let (beacons, _scanning, setScanning) = BeaconScanner.useScanner()
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

  <View>
    <Logo />
    {
      switch appState {
        | StateProvider.ScanningBeacon when selected->Option.isSome => {
          <View>
            <Text>{("Going to pair with " ++ selected->Option.map(beacon => beacon.minor->Int.toString)->Option.getWithDefault(""))->React.string}</Text>
            <Button title="Yes" onPress={_ => selected->Option.map(saveBeacon) |> ignore} />
            <Button title="No" onPress={_ => setSelected(_ => None)} />
          </View>
        }
        | StateProvider.BeaconSaved(beacon) => {
          <View>
            <Text>{("Paired with " ++ beacon.minor->Int.toString)->React.string}</Text>
            <Button title="Proceed" onPress={_ => confirmSaved()} />
          </View>
        }
        | _ => React.null
      }
    }
    <FlatList
      data=beacons
      renderItem={({item, _}) => <BeaconRow beacon={item} onSelect={_ => setSelected(_ => Some(item))} />}
      keyExtractor={(beacon, _) => beacon.minor->Int.toString}
      />
  </View>
}
