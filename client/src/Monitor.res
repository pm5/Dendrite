open Belt

// XXX for tests
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
let useMonitor = (user) => {
  let (neighbors: array<Neighbor.t>, setNeighbors) = React.useState(() => [])
  let (danger: option<(Neighbor.t, Pathogen.t)>, setDanger) = React.useState(() => None)

  React.useEffect1(() => {
    let dangers = user->Neighbor.dangeredBy(neighbors)
    if dangers->Array.length > 0 {
      // XXX POST report
      setDanger(_ => dangers->Array.get(0))
    }
    Some(() => setDanger(_ => None))
  }, [neighbors])

  // XXX for tets
  React.useEffect0(() => {
    let job = Js.Global.setInterval(() => {
      setNeighbors(_ => samples)
    }, 10000)
    Some(() => Js.Global.clearInterval(job))
  })

  (neighbors, danger)
}
