open ReactNative

module AppScreen = {
  @react.component
  let make = () => {
    let (state, _setState) = React.useContext(StateProvider.stateContext)

    {switch state {
      | Start => <StartScreen />
      | ScanningBeacon | BeaconSaved(_) | BeaconPaired(_) => <PairBeaconScreen />
      | LoadingUser(beacon) | UserLoaded(beacon, _) => <LoadUserScreen beacon />
      | Monitoring(beacon, user) => <MonitorScreen beacon user />
    }}
  }
}

module Root = {
  @react.component
  let make = (~children) => <View style={ScreenStyle.styles["background"]}>{children}</View>
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

  React.useEffect0(() => {
    open Async
    Storage.loadBeacon()->then_(beacon => {
      Storage.loadUser()->then_(user => {
        switch (beacon, user) {
          | (None, _) => setAppState(_ => StateProvider.Start)
          | (Some(beacon), None) => setAppState(_ => StateProvider.LoadingUser(beacon))
          | (Some(beacon), Some(user)) => setAppState(_ => StateProvider.Monitoring(beacon, user))
        }->async
      })
    })->ignore
    None
  })

  <Root>
    <StateProvider value=(appState, setAppState)>
      <AppScreen />
    </StateProvider>
  </Root>
}
