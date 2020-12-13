open Belt

type t = {
  id: string,
  infections: array<Infection.t>,
  vaccinations: array<Vaccination.t>,
  immunities: array<Immunity.t>,
}

let query = id => `
  citizen(id: ${id}) {
    id
    infections { pathogen { name } }
    vaccinations { vaccine { name } }
    immunities { antibody { name, bindsTo { name } } expiresAt }
  }
`

let queryAll = "
  allCitizens {
    id
    infections { pathogen { name } }
    vaccinations { vaccine { name } }
    immunities { antibody { name, bindsTo { name } } expiresAt }
  }
`
"

let to_string = user => user->Js.Json.stringifyAny->Option.getExn
let from_string = Js.Json.parseExn
