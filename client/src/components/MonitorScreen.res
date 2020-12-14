open Belt
open ReactNative

@react.component
let make = (~beacon, ~user) => {
  let (_appState, setAppState) = StateProvider.useContext()
  let (_neighbors, danger) = Monitor.useMonitor(user)

  React.useEffect1(() => {
    switch danger {
      | Some(neighbor, pathogen) => setAppState(StateProvider.take(StateProvider.WarnUser(neighbor, pathogen)))
      | None => ()
    }
    None
  }, [danger])

  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Button
        onPress={_ => setAppState(_ => StateProvider.WarningUser(beacon, user, Monitor.samples[0]->Option.getExn, { Pathogen.name: "foo" }))}
        title="Danger found"
        />
    </View>
  </>
}
