open ReactNative
open Belt

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

    let clearBeacon = () => {
      ()
    }

    <>
      <View>
        <Text>{"Start Screen"->React.string}</Text>
        <Button
          onPress={_ => setAppState(_ => State.ScanningBeacon)}
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
        <Button
          onPress={_ => clearBeacon()}
          title="Clear beacon data"
          />
      </View>
    </>
  }
}

module Beacon = {
  type t = { id: string }
}

module PairBeaconScreen = {
  @react.component
  let make = () => {
    let (appState, setAppState) = React.useContext(StateProvider.stateContext)
    let (beacons, setBeacons) = React.useState(() => [ { Beacon.id: "123" } ])
    let (selected: option<Beacon.t>, setSelected) = React.useState(() => None)

    let saveBeacon = _ => {
      setAppState(State.next(SaveBeacon))
    }

    let confirmSaved = () => {
      setAppState(State.next(ConfirmBeaconSaved))
    }

    <>
      <View>
        <Text>{"Pairing beacon"->React.string}</Text>
        {
          if appState == State.ScanningBeacon && selected->Option.isSome {
            <View>
              <Button title="Yes" onPress={_ => saveBeacon(selected)} />
              <Button title="No" onPress={_ => setSelected(_ => None)} />
            </View>
          } else if appState == State.BeaconPaired {
            <View>
              <Button title="Proceed" onPress={_ => confirmSaved()} />
            </View>
          } else {
            React.null
          }
        }
        <FlatList
          data=beacons
          renderItem={({ VirtualizedList.item, _ }) =>
              <View key=item.id>
                <Text key=item.id>{ item.id->React.string }</Text>
                <Button
                  title="Select"
                  onPress={_ => setSelected(_ => Some(item))}
                  />
              </View>
          }
          keyExtractor={(beacon, _) => beacon.id}
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
          setAppState(_ => State.BeaconUnpaired)
          None
        }
        | State.ErrorUserNotFound => {
          setAppState(_ => State.BeaconUnpaired)
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
  let (appState, setAppState) = React.useState(() => State.Start)
  <>
    <StateProvider value=(appState, setAppState)>
      <AppView />
    </StateProvider>
  </>
}
