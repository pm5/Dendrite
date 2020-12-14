open Belt
open ReactNative

@react.component
let make = (~beacon as _, ~user, ~neighbor, ~pathogen) => {
  let (_, setAppState) = React.useContext(StateProvider.stateContext)
  let (_, _danger, setDanger) = Monitor.useMonitor(user, setAppState)

  <>
    <View>
      <Text>{"Warning!"->React.string}</Text>
      <Text>{("This person " ++ neighbor.Neighbor.citizen.id ++ " is dangerous to you.")->React.string}</Text>
      <Text>{("Carries " ++ pathogen.Pathogen.name ++ " within " ++ neighbor.Neighbor.distanceInMeters->Float.toString ++ " meters.")->React.string}</Text>
      <Button
        onPress={_ => setDanger(_ => None)}
        title="Danger cleared"
        />
    </View>
  </>
}
