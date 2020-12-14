open ReactNative;

@react.component
let make = (~data) => {
  <FlatList
    data=data
    renderItem={({item}) => (
      <View>
        <Text>{item.Beacon.uid->React.string}</Text>
        <Text>{item.Beacon.rssi->Js.Float.toString->React.string}</Text>
        <Text>{item.Beacon.txPower->Js.Float.toString->React.string}</Text>
      </View>
    )}
    keyExtractor={(_, i) => Js.Int.toString(i)}
    />
}
