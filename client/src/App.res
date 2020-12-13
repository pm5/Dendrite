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
          onPress={_ => setAppState(_ => StateProvider.NoUserStored)}
          title="No user data"
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

module LoadUserScreen = {
  @react.component
  let make = () => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    React.useEffect1(() =>
      switch (appState) {
        | StateProvider.NoUserStored => {
          setAppState(_ => StateProvider.DownloadingUser)
          None
        }
        | StateProvider.DownloadingUser => {
          setAppState(_ => StateProvider.UserJustStored)
          None
        }
        | StateProvider.UserJustStored => {
          setAppState(_ => StateProvider.Start)
          None
        }
        | StateProvider.ErrorUserInvalid => {
          setAppState(_ => StateProvider.BeaconUnpaired)
          None
        }
        | StateProvider.ErrorUserNotFound => {
          setAppState(_ => StateProvider.BeaconUnpaired)
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
        | StateProvider.Initializing => {
          setAppState(_ => StateProvider.Monitoring)
          None
        }
        | StateProvider.Monitoring => {
          None
        }
        | StateProvider.NearbyUserDetected => {
          setAppState(_ => StateProvider.QueryingUser)
          None
        }
        | StateProvider.QueryingUser => {
          setAppState(_ => StateProvider.Monitoring)
          None
        }
        | _ => None
      },
      [appState])
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
        <Button
          onPress={_ => setAppState(_ => StateProvider.Monitoring)}
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
        | ScanningBeacon | BeaconPaired | BeaconUnpaired => <PairBeaconScreen />
        | NoUserStored | DownloadingUser | UserJustStored | ErrorUserInvalid | ErrorUserNotFound => <LoadUserScreen />
        | Initializing | Monitoring | NearbyUserDetected | QueryingUser => <MonitorScreen />
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
  <>
    <StateProvider value=(appState, setAppState)>
      <AppView />
    </StateProvider>
  </>
}
