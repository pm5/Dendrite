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
module ReloadInstructions = {
  @react.component @bs.module("react-native/Libraries/NewAppScreen")
  external make: _ => React.element = "ReloadInstructions"
}
module LearnMoreLinks = {
  @react.component @bs.module("react-native/Libraries/NewAppScreen")
  external make: _ => React.element = "LearnMoreLinks"
}
module DebugInstructions = {
  @react.component @bs.module("react-native/Libraries/NewAppScreen")
  external make: _ => React.element = "DebugInstructions"
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

module Greeting = {
  @react.component
  let make = (~name) => {
    let (count, setCount) = React.useState(() => 0)
    let (userName, setUserName) = React.useState(() => name)

    <View style={styles["sectionContainer"]}>
      <TextInput style={styles["sectionDescription"]}
        defaultValue={userName}
        onChangeText={text => setUserName((_) => text)}
        />
      <Text style={styles["sectionDescription"]}>
        {("Hello, " ++ userName ++ ".  You have clicked " ++ string_of_int(count) ++ " times.")->React.string}
      </Text>
      <Button
        onPress={_event => setCount((_) => count + 1)}
        title="Click me"
        />
    </View>
  }
}

module LotsOfGreetings = {
  type t = { name : string }

  @react.component
  let make = () => {
    <FlatList
      data={[
        { name: "Devin" },
        { name: "Dan" },
        { name: "Dominic" },
        { name: "Jackson" },
        { name: "James" },
        { name: "Joel" },
        { name: "Jane" },
        { name: "John" },
        { name: "Jillion" },
        ]}
      renderItem={({item}) =>
        <Greeting name={item.name} />
      }
      keyExtractor={(item, _) => item.name}
      />
  }
}

module Movies = {
  type movie = {
    id : string,
    title : string,
    releaseYear : string,
  };

  type t = {
    title : string,
    description : string,
    movies : array<movie>,
  };

  @bs.scope("JSON") @bs.val
  external of_json : string => t = "parse";

  @react.component
  let make = () => {
    let (count, setCount) = React.useState(() => 0)
    let (movies, setMovies) = React.useState(() => [])
    let (loading, setLoading) = React.useState(() => true)

/*
    React.useEffect1(() => {
      let refresh = () => {
        setLoading(_ => true)
      }
      let timeoutID = Js.Global.setInterval(refresh, 4000)
      Some(() => Js.Global.clearInterval(timeoutID))
    }, [])
    */

    React.useEffect1(() => {
      open Js.Promise
      if loading {
        let _ = Fetch.fetch("https://reactnative.dev/movies.json")
          |> then_(Fetch.Response.text)
          |> then_(text => of_json(text) |> resolve)
          |> then_(moviesData => {
            setMovies(_ => moviesData.movies)
            setLoading(_ => false)
            setCount(x => x + 1)
            resolve ()
          })
          |> catch(error => Js.log(error) |> resolve)
      }
      None
    }, [ loading ])

    if loading {
      <View style={styles["sectionContainer"]}>
        <Text>{"Loading..."->React.string}</Text>
      </View>
    } else {
      <View style={styles["sectionContainer"]}>
        <Text>{`Loaded ${string_of_int(count)} times`->React.string}</Text>
        <FlatList
          data={movies}
          renderItem={({item}) => (
            <View>
              <Text>{item.id->React.string}</Text>
              <Text>{item.title->React.string}</Text>
              <Text>{item.releaseYear->React.string}</Text>
            </View>
          )}
          keyExtractor={(item, _) => item.id}
        >
        </FlatList>
        <Button
          onPress={_event => setLoading(_ => true)}
          title="Reload"
          />
      </View>
    }
  }
}

@react.component
let app = () => {

  let logger = url => {
    Js.log(url.EddyStone.url)
  }
  EddyStone.addListener(#onURLFrame(logger))
  EddyStone.startScanning()
  EddyStone.stopScanning()
  EddyStone.removeListener(#onURLFrame(logger))

  <>
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
          <Movies />
          <Greeting name="pm5" />
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionTitle"]}> {"Step One"->React.string} </Text>
            <Text style={styles["sectionDescription"]}>
              {"Edit "->React.string}
              <Text style={styles["highlight"]}> {"src/App.re"->React.string} </Text>
              {" to change this screen and then come back to see your edits."->React.string}
            </Text>
          </View>
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionTitle"]}> {"See Your Changes"->React.string} </Text>
            <Text style={styles["sectionDescription"]}> <ReloadInstructions /> </Text>
          </View>
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionTitle"]}> {"Debug"->React.string} </Text>
            <Text style={styles["sectionDescription"]}> <DebugInstructions /> </Text>
          </View>
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionTitle"]}> {"Learn More"->React.string} </Text>
            <Text style={styles["sectionDescription"]}>
              {"Read the docs to discover what to do next:"->React.string}
            </Text>
          </View>
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionDescription"]}>
              <Text style={styles["highlight"]}> {"Reason React Native"->React.string} </Text>
            </Text>
            <TouchableOpacity
              onPress={_ => openURLInBrowser("https://reason-react-native.github.io/en/docs/")}>
              <Text
                style={
                  open Style
                  style(
                    ~marginTop=8.->dp,
                    ~fontSize=18.,
                    ~fontWeight=#_400,
                    ~color=colors["primary"],
                    (),
                  )
                }>
                {"https://reason-react-native.github.io/"->React.string}
              </Text>
            </TouchableOpacity>
          </View>
          <View style={styles["sectionContainer"]}>
            <Text style={styles["sectionDescription"]}>
              <Text style={styles["highlight"]}> {"React Native"->React.string} </Text>
            </Text>
          </View>
          <LearnMoreLinks />
        </View>
      </ScrollView>
    </SafeAreaView>
  </>
}
