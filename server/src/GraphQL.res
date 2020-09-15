
module Pathogen = {
  type id = string
  type t = {
    id: id
    name: string
    version: string
    spreadDistanceInMeters: float
    spreadTimeInSeconds: float
    spreadRatio: float
  }
}

module Antibody = {
  type id = string
  type t = {
    id: id
    name: string
    version: string
    bindsTo: array<Pathogen.id>
    expiresInSeconds: float
  }
}

module Vaccine = {
  type id = string
  type t = {
    id: id
    name: string
    version: string
    generates: Antibody.id
    effectiveAfterSeconds: float
  }
}

module Infection = {
  type t = {
    pathogen: Pathogen.id
    infectedAt: Js.Date.t
  }
}

module Vaccination = {
  type t = {
    vaccine: Vaccine.id
    adminedAt: Js.Date.t
  }
}

module Immunity = {
  type t = {
    antibody: Antibody.id
    expiresAt: Js.Date.t
  }
}

module Citizen = {
  type id = string
  type t = {
    id: id
    infections: array<Infection.t>
    vaccinations: array<Vaccination.t>
    immunities: array<Immunity.t>
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
    generates: Vaccine.t => Antibody.t
  }
  type antibodyQuery = {
    bindsTo: Antibody.t => array<Pathogen.t>
  }
  type infectionQuery = {
    pathogen: Infection.t => Pathogen.t
  }
  type vaccinationQuery = {
    vaccine: Vaccination.t =>  Vaccine.t
  }
  type immunityQuery = {
    antibody: Immunity.t => Antibody.t
  }
  type citizeQuery = {
    infections: Citizen.t => array<Infection.t>
    vaccinations: Citizen.t => array<Vaccination.t>
    immunities: Citizen.t => array<Immunity.t>
  }
  type query = {
      allCitizens: (obj, args, info, context) => array<Citizen.t>
      allPathogens: (obj, args, info, context) => array<Pathogen.t>
      allVaccines: (obj, args, info, context) => array<Vaccine.t>
      allAntibodies: (obj, args, info, context) => array<Antibody.t>
      citizen: (obj, args, info, context) => option<Citizen.t>
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

