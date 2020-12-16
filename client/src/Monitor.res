open Belt

let useNeighbors = () => {
  let (allCitizens: HashMap.String.t<Citizen.t>, setAllCitizens) = React.useState(
    () => HashMap.String.make(~hintSize=30)
  )
  let (beacons, _scanning, setScanning) = BeaconScanner.useScanner()
  let (neighbors: option<array<Neighbor.t>>, setNeighbors) = React.useState(() => None)

  React.useEffect1(() => {
    open Async
    Db.allCitizens()
      ->then_(citizens => {
        setAllCitizens(_ => {
          citizens
            ->Array.map(citizen => (citizen.id, citizen))
            ->HashMap.String.fromArray
        })->async
      })
      ->catch(err => Js.log(err)->async)
      ->ignore
    None
  }, [beacons])

  React.useEffect2(() => {
    setNeighbors(_ => {
      let neighbors = beacons
        ->Array.keepMap(beacon =>
          allCitizens
            ->HashMap.String.get(beacon->Beacon.toCitizenId)
            ->Option.map(citizen => {
              Neighbor.citizen: citizen,
              distanceInMeters: beacon.Beacon.distance,
              measuredAt: Js.Date.make(),
            })
        )
      Some(neighbors)
    })
    None
  }, (allCitizens, beacons))

  React.useEffect0(() => {
    setScanning(_ => true)
    Some(_ => setScanning(_ => false))
  })

  (neighbors)
}

let useMonitor = (user) => {
  let (neighbors) = useNeighbors()
  let (danger: option<(Neighbor.t, Pathogen.t)>, setDanger) = React.useState(() => None)

  React.useEffect1(() => {
    neighbors->Option.map(neighbors => {
      let dangers = user->Neighbor.dangeredBy(neighbors)
      if dangers->Array.length > 0 {
        // XXX POST report
        Js.log(dangers->Array.get(0))
        setDanger(_ => dangers->Array.get(0))
      }
    }) |> ignore
    Some(() => setDanger(_ => None))
  }, [neighbors])

  (neighbors, danger, setDanger)
}
