open Belt

@decco
type t = {
  id: string,
  infections: array<Infection.t>,
  vaccinations: array<Vaccination.t>,
  immunities: array<Immunity.t>,
}

type query = {
  query: string
}

let one = id => {
  query: `
    {
      citizen(id: "${id}") {
        id
        infections { pathogen { name }, infectedAt }
        vaccinations { vaccine { name }, adminedAt }
        immunities { antibody { name, bindsTo { name } } expiresAt }
      }
    }
    `
}->Js.Json.stringifyAny->Option.getExn

@decco
type one = {
  citizen: t
}

@decco
type one_result = {
  data: one
}

let all = "
{
  allCitizens {
    id
    infections { pathogen { name }, infectedAt }
    vaccinations { vaccine { name }, adminedAt }
    immunities { antibody { name, bindsTo { name } } expiresAt }
  }
}
"

@decco
type all = {
  allCitizens: array<t>
}

@decco
type all_result = {
  data: all
}

let toString = (user: t) => user->Js.Json.stringifyAny->Option.getExn
let fromString = Js.Json.parseExn
