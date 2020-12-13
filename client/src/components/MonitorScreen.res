open ReactNative

let samples = [
  {
    Citizen.id: "012",
    infections: [],
    vaccinations: [],
    immunities: [],
  },
]

@react.component
let make = (~beacon as _, ~user as _) => {
  let (_appState, setAppState) = StateProvider.useContext()
  let (_neighbors: array<Citizen.t>, setNeighbors) = React.useState(() => [])
  let (_danger: option<Citizen.t>, _setDanger) = React.useState(() => None)

  React.useEffect0(() => {
    let job = Js.Global.setInterval(() => {
      setNeighbors(_ => samples)
    }, 10000)
    Some(() => Js.Global.clearInterval(job))
  })

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
