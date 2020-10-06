@ocaml.doc(
  "
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Converted from https://github.com/facebook/react-native/blob/724fe11472cb874ce89657b2c3e7842feff04205/template/App.js
 * With a few tweaks
 "
)
open ReactNative

type reactNativeNewAppScreenColors = {
  "primary": string,
  "white": string,
  "lighter": string,
  "light": string,
  "black": string,
  "dark": string,
}

@bs.module("react-native/Libraries/NewAppScreen")
external colors: reactNativeNewAppScreenColors = "Colors"

@bs.module("react-native/Libraries/Core/Devtools/openURLInBrowser")
external openURLInBrowser: string => unit = "default"

module Header = {
  @react.component @bs.module("react-native/Libraries/NewAppScreen")
  external make: _ => React.element = "Header"
}

/*
 Here is StyleSheet that is using Style module to define styles for your components
 The main different with JavaScript components you may encounter in React Native
 is the fact that they **must** be defined before being referenced
 (so before actual component definitions)
 More at https://reason-react-native.github.io/en/docs/apis/Style/
 */
let styles = {
  open Style
  StyleSheet.create({
    "scrollView": style(~backgroundColor=colors["lighter"], ()),
    "engine": style(~position=#absolute, ~right=0.->dp, ()),
    "body": style(~backgroundColor=colors["white"], ()),
    "sectionContainer": style(~marginTop=32.->dp, ~paddingHorizontal=24.->dp, ()),
    "sectionTitle": style(~fontSize=24., ~fontWeight=#_600, ~color=colors["black"], ()),
    "sectionDescription": style(
      ~marginTop=8.->dp,
      ~fontSize=18.,
      ~fontWeight=#_400,
      ~color=colors["dark"],
      (),
    ),
    "highlight": style(~fontWeight=#_700, ()),
    "footer": style(
      ~color=colors["dark"],
      ~fontSize=12.,
      ~fontWeight=#_600,
      ~padding=4.->dp,
      ~paddingRight=12.->dp,
      ~textAlign=#right,
      (),
    ),
  })
}

module State = {
  type t =
    | AppStart
    | SetupBeacon
    | SaveBeacon
    | Monitoring
    | UpdateNeighbors
    | SendNeighbors
    | ReceiveStates
}

module StateProvider = {
  let stateContext = React.createContext(State.AppStart)

  /// XXX
  //include React.Context
  /// this works
  let makeProps = (~value, ~children, ()) => {
    "value": value,
    "children": children,
  }

  let make = React.Context.provider(stateContext)
}

module BeaconScanner = {
  let useScanner = () => {
    let (scanning, setScanning) = React.useState(() => false)
    let data : EddyStone.BeaconData.t =
      { id: "0"
      , uid : "0x00"
      , rssi : 0.1
      , txPower : 0.01,
      }
    let (beacons, setBeacons) = React.useState(() => { "beacons": [
      data
    ] })

    let beaconListener = (d) => {
      Js.log("wooty")
      setBeacons(beacons => {
        "beacons": beacons["beacons"]->Js.Array.concat([ d ])->Js.Array.slice(~start=0, ~end_=10)
      })
    }

    React.useEffect1(() => {
      Js.log("woot")
      EddyStone.addListener(#onUIDFrame(beaconListener))
      EddyStone.startScanning()
      Some(() => {
        EddyStone.stopScanning()
        EddyStone.removeListener(#onUIDFrame(beaconListener))
        Js.log("uoot")
      })
    }, [ scanning ])

    (beacons, scanning, setScanning)
  }

  module BeaconList = {
    @react.component
    let make = (~data) => {
      <FlatList
        data=data
        renderItem={({item}) => (
          <View>
            <Text>{item.EddyStone.BeaconData.uid->React.string}</Text>
            <Text>{item.EddyStone.BeaconData.rssi->Js.Float.toString->React.string}</Text>
            <Text>{item.EddyStone.BeaconData.txPower->Js.Float.toString->React.string}</Text>
          </View>
        )}
        keyExtractor={(_, i) => string_of_int(i)}
        />
    }
  }

  @react.component
  let make = () => {
    let (beacons, scanning, setScanning) = useScanner()

    <View style={styles["sectionContainer"]}>
      <BeaconList data={beacons["beacons"]} />
      <Button
        onPress={ _ => setScanning(s => !s) }
        title={ (if scanning { "Stop" } else { "Start" }) }
        />
    </View>
  }
}

@react.component
let app = () => {
  <>
    <StateProvider value={State.AppStart}>
      <StatusBar barStyle=#darkContent />
      <SafeAreaView>
        <ScrollView contentInsetAdjustmentBehavior=#automatic style={styles["scrollView"]}>
          {Global.hermesInternal->Belt.Option.isNone
            ? React.null
            : <View style={styles["engine"]}>
                <Text style={styles["footer"]}> {"Engine: Hermes"->React.string} </Text>
              </View>}
          <Header />
          <View style={styles["body"]}>
            <BeaconScanner />
          </View>
        </ScrollView>
      </SafeAreaView>
    </StateProvider>
  </>
}
