open ReactNative

module StateProvider = {
  let stateContext = React.createContext((State.Start, _ => ()))

  /// XXX
  let makeProps = (~value, ~children, ()) => {
    "value": value,
    "children": children,
  }
  let make = React.Context.provider(stateContext)
}

module StartScreen = {
  @react.component
  let make = () => {
    let (_, setAppState) = React.useContext(StateProvider.stateContext)
    <>
      <View>
        <Text>{"Start Screen"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => State.Monitoring)}
          title="Go"
          />
      </View>
    </>
  }
}

module Monitor = {
  @react.component
  let make = () => {
    let (_, setAppState) = React.useContext(StateProvider.stateContext)
    <>
      <View>
        <Text>{"Monitor"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => State.Start)}
          title="Back"
          />
      </View>
    </>
  }
}

module AppView = {
  @react.component
  let make = () => {
    let (state, _setState) = React.useContext(StateProvider.stateContext)
    <>
      {switch state {
        | Start => <StartScreen />
        | _ => <Monitor />
      }}
    </>
  }
}

@react.component
let app = () => {
  let (appState, setAppState) = React.useState(() => State.Start)
  <>
    <StateProvider value=(appState, setAppState)>
      <AppView />
    </StateProvider>
  </>
}
