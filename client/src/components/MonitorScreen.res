open ReactNative

@react.component
let make = (~beacon as _, ~user as _) => {
  let (_appState, setAppState) = React.useContext(StateProvider.stateContext)
  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Button
        onPress={_ => setAppState(_ => StateProvider.NearbyUserDetected)}
        title="Nearby found"
        />
      <Button
        onPress={_ => setAppState(_ => StateProvider.WarningUser)}
        title="Danger found"
        />
    </View>
  </>
}
