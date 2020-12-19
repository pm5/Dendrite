open Belt
open ReactNative

module ImmunityRow = {
  @react.component
  let make = (~immunity: Immunity.t) => <Text style={ScreenStyle.styles["text"]}>{immunity.antibody.name->React.string}</Text>
}

module InfectionRow = {
  @react.component
  let make = (~infection: Infection.t) => <Text style={ScreenStyle.styles["text"]}>{infection.pathogen.name->React.string}</Text>
}

@react.component
let make = (~user: Citizen.t) =>
  <>
    <View>
      <Text style={ScreenStyle.styles["text"]}>{"Your immunities"->React.string}</Text>
      <ScrollView>
      {
        user.immunities
          ->Array.mapWithIndex((index, immunity) => <ImmunityRow immunity key={index->Int.toString} />)
          ->React.array
      }
      </ScrollView>
    </View>
    <View>
      <Text style={ScreenStyle.styles["text"]}>{"Your infections"->React.string}</Text>
      <ScrollView>
      {
        user.infections
          ->Array.mapWithIndex((index, infection) => <InfectionRow infection key={index->Int.toString} />)
          ->React.array
      }
      </ScrollView>
    </View>
  </>
