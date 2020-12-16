open Belt
open ReactNative

let reset = (setAppState) => {
  open Async
  Storage.resetBeacon()
    ->then_(() => Storage.resetUser())
    ->then_(() => setAppState(_ => StateProvider.Start)->async)
    ->ignore
}

@react.component
let make = (~beacon as _, ~user) => {
  let (_, setAppState) = StateProvider.useContext()
  let (neighbors, danger, _setDanger) = Monitor.useMonitor(user)

  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Text>{(neighbors->Option.map(neighbors => neighbors->Array.length->Int.toString ++ " neighbors"))->Option.getWithDefault("No results yet")->React.string}</Text>
      <Text>{
        switch danger {
          | Some(neighbor, pathogen) => neighbor.citizen.id ++ " within " ++ neighbor.distanceInMeters->Float.toString ++ " meter(s) is dangerous because of " ++ pathogen.name
          | None => "No danger"
        }->React.string
      }</Text>
      <Button
        onPress={_ => reset(setAppState)}
        title="Reset"
        />
    </View>
  </>
}
