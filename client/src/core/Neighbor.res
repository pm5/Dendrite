open Belt

type t = {
  citizen: Citizen.t,
  distanceInMeters: float,
  measuredAt: Js.Date.t,
}

let fromBeaconsWithCitizens = (_beacons, _citizens) => ()

let dangeredBy = (user, neighbors: array<t>) => {

  let danger = (immunes, stranger: t) => {
    stranger.citizen.Citizen.infections
      ->Array.keep(inf => !(immunes->Array.some(immune => immune == inf.pathogen.name)))
      ->Array.keep(inf => stranger.distanceInMeters < inf.pathogen.spreadDistanceInMeters)
      ->Array.map(inf => (stranger, inf.pathogen))
  }

  let immunes = user.Citizen.immunities
    ->Array.map(i => i.antibody.bindsTo->Array.map(p => p.Pathogen.name))
    ->Array.reduce([], Array.concat)

  neighbors
    ->Array.map(danger(immunes))
    ->Array.reduce([], Array.concat)
}
