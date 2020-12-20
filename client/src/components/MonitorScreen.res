open Belt
open ReactNative

let styles = {
  open Style
  StyleSheet.create({
    "warning": textStyle(
      ~backgroundColor="#f00",
      ~color="#fff",
      ~fontSize=18.,
      ~fontWeight=#bold,
      ~textAlign=#center,
      ~padding=6.->dp,
      ()),
    "danger": textStyle(
      ~color="#fff",
      ~fontSize=18.,
      ~fontWeight=#bold,
      ~textAlign=#center,
      ~paddingTop=6.->dp,
      ~paddingBottom=0.->dp,
      ()),
    "suggest": textStyle(
      ~color="#fff",
      ~fontSize=18.,
      ~fontWeight=#bold,
      ~textAlign=#center,
      ~padding=2.->dp,
      ()),
    "statusList": viewStyle(
      ~height=150.->dp,
      ()),
  })
}

let reset = (setAppState) => {
  open Async
  Storage.resetBeacon()
    ->then_(() => Storage.resetUser())
    ->then_(() => setAppState(_ => StateProvider.Start)->async)
    ->ignore
}

module ImmunityRow = {
  @react.component
  let make = (~immunity: Immunity.t) =>
    <View style={Style.style(~flexDirection=#row, ())}>
      <Text style={ScreenStyle.styles["text"]}>
        {(immunity.antibody.name ++ "... ")->React.string}
      </Text>
      <Text style={Style.array([ScreenStyle.styles["text"], Style.style(~color="#0f0", ())])}>
        {"IMMUNE"->React.string}
      </Text>
    </View>
}

module InfectionRow = {
  @react.component
  let make = (~infection: Infection.t) =>
    <View style={Style.style(~flexDirection=#row, ())}>
      <Text style={ScreenStyle.styles["text"]}>
        {(infection.pathogen.name ++ "... ")->React.string}
      </Text>
      <Text style={Style.array([ScreenStyle.styles["text"], Style.style(~color="#f00", ())])}>
        {"INFECTED!"->React.string}
      </Text>
    </View>
}

module WarnScreen = {
  @react.component
  let make = (~neighbor: Neighbor.t, ~pathogen: Pathogen.t) => {
    Vibration.vibrateWithDuration(100, ())
    <View>
      <Text style={styles["warning"]}>{"Warning"->React.string}</Text>
      <Text style={styles["danger"]}>{(pathogen.name ++ ": within " ++ ((neighbor.distanceInMeters *. 10.)->Float.toInt->Int.toFloat /. 10.)->Float.toString ++ " meter(s)")->React.string}</Text>
      <Text style={styles["suggest"]}>{"Suggest keeping distance"->React.string}</Text>
      {neighbor.citizen.photo->Array.get(0)->Option.map(photo =>
        <Image
          source={Image.Source.fromUriSource(Image.uriSource(
                  ~uri=photo.Photo.thumbnail.url,
                  ()))}
          style={Style.style(
            ~width=photo.thumbnail.width->Int.toFloat->Style.dp,
            ~height=photo.thumbnail.height->Int.toFloat->Style.dp,
            ())}
          resizeMode=#cover
          />)->Option.getWithDefault(React.null)}
    </View>
  }
}

@react.component
let make = (~beacon as _, ~user) => {
  let (_, setAppState) = StateProvider.useContext()
  let (_neighbors, danger, _setDanger) = Monitor.useMonitor(user)

  let count = Loading.useLoading()

  React.useEffect0(() => {
    open Async
    let task = Js.Global.setInterval(() => {
      Storage.resetUser()
        ->then_(() => {
          setAppState(StateProvider.take(StateProvider.LoadUser))->async
        })
        ->catch(err => Js.log(err)->async)
        ->ignore
    }, 60000 * 1)
    Some(() => Js.Global.clearInterval(task))
  })

  <>
    {
      switch danger {
        | Some(neighbor, pathogen) => <WarnScreen neighbor pathogen />
        | None => {
          open Style
          <View>
            <Logo />
            <Text style={array([ScreenStyle.styles["text"], style(~padding=8.->dp, ())])}>{("Monitoring" ++ (Array.make(count, ".")->Js.String.concatMany("")))->React.string}</Text>
            <View style={styles["statusList"]}>
              <ScrollView>
              {
                user.immunities
                  ->Array.mapWithIndex((index, immunity) => <ImmunityRow immunity key={index->Int.toString} />)
                  ->React.array
              }
              {
                user.infections
                  ->Array.mapWithIndex((index, infection) => <InfectionRow infection key={index->Int.toString} />)
                  ->React.array
              }
              </ScrollView>
            </View>
          </View>
        }
      }
    }
  </>
}
