open ReactNative

@react.component
let make = (~beacon) => {
  let (_, setAppState) = StateProvider.useContext()

  React.useEffect0(() => {
    open Async
    let id = beacon->Beacon.toCitizenId
    Db.citizen(id)
      ->then_(user => {
        Storage.saveUser(user)
          ->then_(() => user->async)
      })
      ->then_(user => {
        setAppState(StateProvider.take(StateProvider.SaveUser(user)))->async
      })
      ->catch(err => Js.log(err)->async)
      ->ignore
    None
  })

  let count = Loading.useLoading()

  <>
    <View>
      <Text style={ScreenStyle.styles["text"]}>{("Loading user data" ++ Array.make(count, ".")->Js.String.concatMany(""))->React.string}</Text>
    </View>
  </>
}
