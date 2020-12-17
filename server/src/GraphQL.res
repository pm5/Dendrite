
module Pathogen = {
  type id = string
  type t = {
    name: id
    version: string
    spreadDistanceInMeters: float
    spreadTimeInSeconds: float
    spreadRatio: float
  }
}

module Antibody = {
  type id = string
  type t = {
    name: id
    version: string
    bindsTo: array<Pathogen.id>
    expiresInSeconds: float
  }
}

module Vaccine = {
  type id = string
  type t = {
    name: id
    version: string
    generates: Antibody.id
    effectiveAfterSeconds: float
  }
}

module Infection = {
  type id = string
  type t = {
    pathogen: Pathogen.id
    infectedAt: Js.Date.t
  }
}

module Vaccination = {
  type id = string
  type t = {
    vaccine: Vaccine.id
    adminedAt: Js.Date.t
  }
}

module Immunity = {
  type id = string
  type t = {
    antibody: Antibody.id
    expiresAt: Js.Date.t
  }
}

module Thumbtail = {
  type t = {
    url: string
    width: int
    height: int
  }
}

module Photo = {
  type id = string
  type t = {
    id: id
    url: string
    size: int
    thumbnail: Thumbtail.t
  }
}

module Citizen = {
  type id = string
  type t = {
    id: id
    name: string
    infections: array<Infection.id>
    vaccinations: array<Vaccination.id>
    immunities: array<Immunity.id>
    photo: array<Photo.t>
  }
}

module ProximityObservation = {
  type t = {
    citizen: string
    distanceInMeters: float
    measuredAt: Js.Date.t
  }
}

module Resolvers = {
  type obj
  type args = Js.Dict.t<string>
  type info
  type context
  type vaccineQuery = {
    generates: Vaccine.t => Js.Promise.t<Antibody.t>
  }
  type antibodyQuery = {
    bindsTo: Antibody.t => Js.Promise.t<array<Pathogen.t>>
  }
  type infectionQuery = {
    pathogen: Infection.t => Js.Promise.t<Pathogen.t>
  }
  type vaccinationQuery = {
    vaccine: Vaccination.t =>  Js.Promise.t<Vaccine.t>
  }
  type immunityQuery = {
    antibody: Immunity.t => Js.Promise.t<Antibody.t>
  }
  type citizeQuery = {
    infections: Citizen.t => Js.Promise.t<array<Infection.t>>
    vaccinations: Citizen.t => Js.Promise.t<array<Vaccination.t>>
    immunities: Citizen.t => Js.Promise.t<array<Immunity.t>>
  }
  type query = {
      allCitizens: (obj, args, info, context) => Js.Promise.t<array<Citizen.t>>
      allPathogens: (obj, args, info, context) => Js.Promise.t<array<Pathogen.t>>
      allVaccines: (obj, args, info, context) => Js.Promise.t<array<Vaccine.t>>
      allAntibodies: (obj, args, info, context) => Js.Promise.t<array<Antibody.t>>
      citizen: (obj, args, info, context) => Js.Promise.t<Citizen.t>
  }
  type t = {
    @bs.as("Query") query: query
    @bs.as("Vaccine") vaccine: vaccineQuery
    @bs.as("Antibody") antibody: antibodyQuery
    @bs.as("Infection") infection: infectionQuery
    @bs.as("Vaccination") vaccination: vaccinationQuery
    @bs.as("Immunity") immunity: immunityQuery
    @bs.as("Citizen") citizen: citizeQuery
  }
}
