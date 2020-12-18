open ReactNative

@react.component
let make = () => {
  let (_appState, setAppState) = React.useContext(StateProvider.stateContext)

  <View>
    <Logo />
    <Button
      onPress={_ => setAppState(_ => StateProvider.ScanningBeacon)}
      title="Start"
      />
  </View>
}
