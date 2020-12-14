open Belt
open ReactNative

@react.component
let make = (~beacon as _, ~user) => {
  let (_, setAppState) = StateProvider.useContext()
  let (neighbors, danger, setDanger) = Monitor.useMonitor(user, setAppState)

  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Text>{(neighbors->Option.map(neighbors => neighbors->Array.length->Int.toString ++ " neighbors"))->Option.getWithDefault("No results yet")->React.string}</Text>
      <Text>{
        switch danger {
          | Some(neighbor, _pathogen) => neighbor.citizen.id ++ " is dangerous"
          | None => "No danger"
        }->React.string
      }</Text>
      /* XXX for tests */
      <Button
        onPress={_ => setDanger(_ => Some(Monitor.samples[0]->Option.getExn, { Pathogen.name: "foo" }))}
        title="Danger found"
        />
    </View>
  </>
}
