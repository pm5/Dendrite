open ReactNative

@react.component
let make = () => {
  let (_, setAppState) = React.useContext(StateProvider.stateContext)

  <View>
    <Logo />
    <Button
      onPress={_ => setAppState(_ => StateProvider.ScanningBeacon)}
      title="Start"
      />
  </View>
}
