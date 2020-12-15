open Belt
open ReactNative

@react.component
let make = (~data) => {
  <FlatList
    data=data
    renderItem={({item}) => (
      <View>
        <Text>{item.Beacon.uuid->React.string}</Text>
        <Text>{item.Beacon.major->Int.toString->React.string}</Text>
        <Text>{item.Beacon.minor->Int.toString->React.string}</Text>
        <Text>{item.Beacon.distance->Js.Float.toString->React.string}</Text>
      </View>
    )}
    keyExtractor={(_, i) => Js.Int.toString(i)}
    />
}
