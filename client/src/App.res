open Belt

module AppScreen = {
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
      | Start => {
        Js.Global.setTimeout(() => {
          setAppState(StateProvider.take(StateProvider.PairBeacon))
        }, 16000)
        |> ignore
      }
      | BeaconPaired(_) => setAppState(StateProvider.take(StateProvider.LoadUser))
      | UserLoaded(_, _) => setAppState(StateProvider.take(StateProvider.StartMonitor))
      | _ => ()
    }
    None
  }, [appState])

  <>
    <StateProvider value=(appState, setAppState)>
      <AppScreen />
    </StateProvider>
  </>
}
