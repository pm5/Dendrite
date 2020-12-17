open Belt
open ReactNative

let reset = (setAppState) => {
  open Async
  Storage.resetBeacon()
    ->then_(() => Storage.resetUser())
    ->then_(() => setAppState(_ => StateProvider.Start)->async)
    ->ignore
}

@react.component
let make = (~beacon as _, ~user) => {
  let (_, setAppState) = StateProvider.useContext()
  let (neighbors, danger, _setDanger) = Monitor.useMonitor(user)

  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Text>{(neighbors->Option.map(neighbors => neighbors->Array.length->Int.toString ++ " neighbors"))->Option.getWithDefault("No results yet")->React.string}</Text>
      {
        switch danger {
          | Some(neighbor, pathogen) => {
            Js.log(neighbor.citizen.photo[0])
            <View>
              <Text>{(neighbor.citizen.id ++ " within " ++ neighbor.distanceInMeters->Float.toString ++ " meter(s) is dangerous because of " ++ pathogen.name)->React.string}</Text>
              {neighbor.citizen.photo->Array.get(0)->Option.map(photo =>
                <Image
                  source={Image.Source.fromUriSource(Image.uriSource(
                          ~uri=photo.Photo.thumbnail.url,
                          ()))}
                  style={Style.style(
                    ~width=photo.thumbnail.width->Int.toFloat->Style.dp,
                    ~height=photo.thumbnail.height->Int.toFloat->Style.dp,
                    ())}
                  resizeMode=#contain
                  />)->Option.getWithDefault(React.null)}
              <Text>{"yo"->React.string}</Text>
            </View>
          }
          | None => <Text>{"No danger"->React.string}</Text>
        }
      }
      <Button
        onPress={_ => reset(setAppState)}
        title="Reset"
        />
    </View>
  </>
}
