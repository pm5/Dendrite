open Belt

// XXX for tests
let samples: array<Neighbor.t> = [
  {
    Neighbor.citizen: {
      id: "012",
      infections: [
        {
          pathogen: { name: "COVID-22" },
          infectedAt: Js.Date.makeWithYMD(~year=2020., ~month=8., ~date=15., ()),
        }
      ],
      vaccinations: [],
      immunities: [],
    },
    distanceInMeters: 3.0,
    measuredAt: Js.Date.make(),
  },
  {
    citizen: {
      id: "345",
      infections: [],
      vaccinations: [],
      immunities: [],
    },
    distanceInMeters: 1.5,
    measuredAt: Js.Date.make(),
  },
  {
    citizen: {
      id: "678",
      infections: [],
      vaccinations: [],
      immunities: [],
    },
    distanceInMeters: 2.0,
    measuredAt: Js.Date.make(),
  }
]

let useMonitor = (~interval=4000, user, setAppState) => {
  let (neighbors: option<array<Neighbor.t>>, setNeighbors) = React.useState(() => None)
  let (danger: option<(Neighbor.t, Pathogen.t)>, setDanger) = React.useState(() => None)

  React.useEffect1(() => {
    neighbors->Option.map(neighbors => {
      let dangers = user->Neighbor.dangeredBy(neighbors)
      if dangers->Array.length > 0 {
        // XXX POST report
        setDanger(_ => dangers->Array.get(0))
      }
    }) |> ignore
    Some(() => setDanger(_ => None))
  }, [neighbors])

  React.useEffect1(() => {
    if neighbors->Option.isSome {
      switch danger {
        | Some(neighbor, pathogen) => setAppState(StateProvider.take(StateProvider.WarnUser(neighbor, pathogen)))
        | None => setAppState(StateProvider.take(StateProvider.StartMonitor))
      }
    }
    None
  }, [danger])

  // XXX for tets
  React.useEffect0(() => {
    let job = Js.Global.setInterval(() => {
      setNeighbors(_ => Some(samples))
    }, interval)
    Some(() => Js.Global.clearInterval(job))
  })

  (neighbors, danger, setDanger)
}
