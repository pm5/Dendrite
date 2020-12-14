module AppScreen = {
  @react.component
  let make = () => {
    let (state, _setState) = React.useContext(StateProvider.stateContext)
    <>
      {switch state {
        | Start => <StartScreen />
        | ScanningBeacon | BeaconSaved(_) | BeaconPaired(_) => <PairBeaconScreen />
        | LoadingUser(beacon) | UserLoaded(beacon, _) => <LoadUserScreen beacon />
        | Monitoring(beacon, user) => <MonitorScreen beacon user />
        | WarningUser(beacon, user, neighbor, pathogen) => <WarnScreen beacon user neighbor pathogen />
      }}
    </>
  }
}

@react.component
let app = () => {
  let (appState, setAppState) = React.useState(() => StateProvider.Start)

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
      <AppScreen />
    </StateProvider>
  </>
}
