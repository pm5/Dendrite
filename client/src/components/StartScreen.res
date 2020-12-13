open ReactNative

@react.component
let make = () => {
  let (_, setAppState) = React.useContext(StateProvider.stateContext)

  let clearBeacon = () => {
    ()
  }

  <>
    <View>
      <Text>{"Start Screen"->React.string}</Text>
      <Button
        onPress={_ => setAppState(_ => StateProvider.ScanningBeacon)}
        title="No beacon paired"
        />
      <Button
        onPress={_ => setAppState(StateProvider.take(StateProvider.LoadUser))}
        title="No user"
        />
      <Button
        onPress={_ => setAppState(StateProvider.take(StateProvider.StartMonitor))}
        title="All good to go"
        />
      <Button
        onPress={_ => clearBeacon()}
        title="Clear beacon data"
        />
    </View>
  </>
}
