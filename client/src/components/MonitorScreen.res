open Belt
open ReactNative

@react.component
let make = (~beacon as _, ~user) => {
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
    </View>
  </>
}
