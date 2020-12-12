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
          onPress={_ => setAppState(_ => State.NoBeaconPaired)}
          title="No beacon paired"
          />
        <Button
          onPress={_ => setAppState(_ => State.NoUserStored)}
          title="No user data"
          />
        <Button
          onPress={_ => setAppState(_ => State.Initializing)}
          title="All good to go"
          />
      </View>
    </>
  }
}

module PairBeaconScreen = {
  @react.component
  let make = () => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    React.useEffect1(() =>
      switch (appState) {
        | State.BeaconDetected => {
          setAppState(_ => State.BeaconJustPaired)
          None
        }
        | State.BeaconJustPaired => {
          setAppState(_ => State.Start)
          None
        }
        | State.BeaconJustUnpaired => {
          setAppState(_ => State.NoBeaconPaired)
          None
        }
        | _ => None
      },
      [appState])
    <>
      <View>
        <Text>{"Pairing beacon"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => State.BeaconDetected)}
          title="Done"
          />
      </View>
    </>
  }
}

module LoadUserScreen = {
  @react.component
  let make = () => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    React.useEffect1(() =>
      switch (appState) {
        | State.NoUserStored => {
          setAppState(_ => State.DownloadingUser)
          None
        }
        | State.DownloadingUser => {
          setAppState(_ => State.UserJustStored)
          None
        }
        | State.UserJustStored => {
          setAppState(_ => State.Start)
          None
        }
        | State.ErrorUserInvalid => {
          setAppState(_ => State.BeaconJustUnpaired)
          None
        }
        | State.ErrorUserNotFound => {
          setAppState(_ => State.BeaconJustUnpaired)
          None
        }
        | _ => None
      },
      [appState])
    <>
      <View>
        <Text>{"Loading user data"->React.string}</Text>
      </View>
    </>
  }
}

module MonitorScreen = {
  @react.component
  let make = () => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    React.useEffect1(() =>
      switch (appState) {
        | State.Initializing => {
          setAppState(_ => State.Monitoring)
          None
        }
        | State.Monitoring => {
          None
        }
        | State.NearbyUserDetected => {
          setAppState(_ => State.QueryingUser)
          None
        }
        | State.QueryingUser => {
          setAppState(_ => State.Monitoring)
          None
        }
        | _ => None
      },
      [appState])
    <>
      <View>
        <Text>{"Monitor"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => State.NearbyUserDetected)}
          title="Nearby found"
          />
        <Button
          onPress={_ => setAppState(_ => State.WarningUser)}
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
        <Button
          onPress={_ => setAppState(_ => State.Monitoring)}
          title="No danger anymore"
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
        | NoBeaconPaired | BeaconDetected | BeaconJustPaired | BeaconJustUnpaired => <PairBeaconScreen />
        | NoUserStored | DownloadingUser | UserJustStored | ErrorUserInvalid | ErrorUserNotFound => <LoadUserScreen />
        | Initializing | Monitoring | NearbyUserDetected | QueryingUser => <MonitorScreen />
        | WarningUser => <WarnScreen />
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
