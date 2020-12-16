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

  <>
    <View>
      <Text>{("Loading user data from beacon " ++ beacon->Beacon.toCitizenId)->React.string}</Text>
    </View>
  </>
}
