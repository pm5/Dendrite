open ReactNative

@react.component
let make = () => {
  let (_, _setAppState) = React.useContext(StateProvider.stateContext)
  <>
    <View>
      <Text>{"Warning!"->React.string}</Text>
    </View>
  </>
}
