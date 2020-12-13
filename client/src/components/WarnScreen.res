open ReactNative

@react.component
let make = (~beacon as _, ~user as _, ~neighbor as _, ~pathogen as _) => {
  let (_, _setAppState) = React.useContext(StateProvider.stateContext)
  <>
    <View>
      <Text>{"Warning!"->React.string}</Text>
    </View>
  </>
}
