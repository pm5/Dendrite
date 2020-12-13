open ReactNative

@react.component
let make = (~beacon) => {
  let (appState, setAppState) = StateProvider.useContext()
  React.useEffect0(() => {
    open Async
    // XXX for tests
    let _ = Js.Global.setTimeout(() => {
      let user = { User.id: beacon.Beacon.id }
      Storage.saveUser(user)
        ->then_(() => setAppState(StateProvider.take(StateProvider.SaveUser(user)))->async)
        |> ignore
    }, 2000)
    None
  })

  <>
    <View>
      <Text>{("Loading user data from beacon " ++ beacon.Beacon.id)->React.string}</Text>
    </View>
  </>
}