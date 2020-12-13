open Belt
open ReactNative

let samples: array<Neighbor.t> = [
  {
    Neighbor.citizen: {
      id: "012",
      infections: [],
      vaccinations: [],
      immunities: [],
    },
    distanceInMeters: 3.0,
    measuredAt: Js.Date.make(),
  }
]

@react.component
let make = (~beacon, ~user) => {
  let (_appState, setAppState) = StateProvider.useContext()
  let (neighbors: array<Neighbor.t>, setNeighbors) = React.useState(() => [])
  let (_danger: option<(Neighbor.t, Pathogen.t)>, setDanger) = React.useState(() => None)

  React.useEffect0(() => {
    let job = Js.Global.setInterval(() => {
      setNeighbors(_ => samples)
    }, 10000)
    Some(() => Js.Global.clearInterval(job))
  })

  React.useEffect1(() => {
    let dangers = user->Neighbor.dangeredBy(neighbors)
    if dangers->Array.length > 0 {
      // XXX POST report
      setDanger(_ => dangers->Array.get(0))
    }
    Some(() => setDanger(_ => None))
  }, [neighbors])

  <>
    <View>
      <Text>{"Monitor"->React.string}</Text>
      <Button
        onPress={_ => setAppState(_ => StateProvider.WarningUser(beacon, user, samples[0]->Option.getExn, { Pathogen.name: "foo" }))}
        title="Danger found"
        />
    </View>
  </>
}
