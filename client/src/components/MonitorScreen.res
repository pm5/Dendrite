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
      ~padding=6.->dp,
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

module WarnScreen = {
  @react.component
  let make = (~neighbor: Neighbor.t, ~pathogen: Pathogen.t) => {
    <View>
      <Text style={styles["warning"]}>{"Warning"->React.string}</Text>
      <Text style={styles["danger"]}>{(pathogen.name ++ ": within " ++ ((neighbor.distanceInMeters *. 10.)->Float.toInt->Int.toFloat /. 10.)->Float.toString ++ " meter(s)")->React.string}
      </Text>
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
  let (_, _setAppState) = StateProvider.useContext()
  let (_neighbors, danger, _setDanger) = Monitor.useMonitor(user)

  let (count, setCount) = React.useState(() => 1)
  React.useEffect0(() => {
    let task = Js.Global.setInterval(() => {
      setCount(c => c > 20 ? 1 : c + 1)
    }, 1200)
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
          </View>
        }
      }
    }
  </>
}
