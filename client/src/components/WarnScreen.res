open Belt
open ReactNative

@react.component
let make = (~beacon as _, ~user as _, ~neighbor, ~pathogen) => {
  let (_, _setAppState) = React.useContext(StateProvider.stateContext)
  <>
    <View>
      <Text>{"Warning!"->React.string}</Text>
      <Text>{("This person " ++ neighbor.Neighbor.citizen.id ++ " is dangerous to you.")->React.string}</Text>
      <Text>{("Carries " ++ pathogen.Pathogen.name ++ " within " ++ neighbor.Neighbor.distanceInMeters->Float.toString ++ " meters.")->React.string}</Text>
    </View>
  </>
}
