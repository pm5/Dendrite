open ReactNative

@react.component
let make = () => {
  let (_, _setAppState) = React.useContext(StateProvider.stateContext)

  <View style={
    open Style
    viewStyle(~maxWidth=300.->dp, ~alignItems=#center, ())
  }>
    <Logo />
    <Text style={
      open Style
      array([ScreenStyle.styles["text"], textStyle(~paddingTop=14.->dp, ())])
      }>
      {"Ultra Immune Taipei City needs you to grant Location permission in order to protect you.  Please grant Location permissions manually in Android settings."->React.string}
    </Text>
  </View>
}
