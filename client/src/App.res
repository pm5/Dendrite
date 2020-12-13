open Belt
open ReactNative

module StartScreen = {
  @react.component
  let make = () => {
    let (_, setAppState) = React.useContext(StateProvider.stateContext)

    let clearBeacon = () => {
      ()
    }

    <>
      <View>
        <Text>{"Start Screen"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => StateProvider.ScanningBeacon)}
          title="No beacon paired"
          />
        <Button
          onPress={_ => setAppState(StateProvider.take(StateProvider.LoadUser))}
          title="No user"
          />
        <Button
          onPress={_ => setAppState(_ => StateProvider.Initializing)}
          title="All good to go"
          />
        <Button
          onPress={_ => clearBeacon()}
          title="Clear beacon data"
          />
      </View>
    </>
  }
}

module MonitorScreen = {
  @react.component
  let make = (~beacon as _, ~user as _) => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    <>
      <View>
        <Text>{"Monitor"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => StateProvider.NearbyUserDetected)}
          title="Nearby found"
          />
        <Button
          onPress={_ => setAppState(_ => StateProvider.WarningUser)}
          title="Danger found"
          />
      </View>
    </>
  }
}

module WarnScreen = {
  @react.component
  let make = () => {
    let (_, setAppState) = React.useContext(StateProvider.stateContext)
    <>
      <View>
        <Text>{"Warning!"->React.string}</Text>
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
        | ScanningBeacon | BeaconSaved(_) | BeaconPaired(_) => <PairBeaconScreen />
        | LoadingUser(beacon) | UserLoaded(beacon, _) => <LoadUserScreen beacon=beacon />
        | Monitoring(beacon, user) => <MonitorScreen beacon=beacon user=user />
        | WarningUser => <WarnScreen />
      }}
    </>
  }
}

@react.component
let app = () => {
  let (appState, setAppState) = React.useState(() => StateProvider.Start)

  {
    open Async
    Storage.loadBeacon()
      ->then_(b => b->Option.map(beacon => Js.log(beacon.id))->async)
      |> ignore
  }

  React.useEffect1(() => {
    switch appState {
      | BeaconPaired(_) => setAppState(StateProvider.take(StateProvider.LoadUser))
      | UserLoaded(_, _) => setAppState(StateProvider.take(StateProvider.StartMonitor))
      | _ => ()
    }
    None
  }, [appState])

  <>
    <StateProvider value=(appState, setAppState)>
      <AppView />
    </StateProvider>
  </>
}
