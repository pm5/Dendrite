open ReactNative;

@react.component
let make = (~data) => {
  <FlatList
    data=data
    renderItem={({item}) => (
      <View>
        <Text>{item.EddyStone.BeaconData.uid->React.string}</Text>
        <Text>{item.EddyStone.BeaconData.rssi->Js.Float.toString->React.string}</Text>
        <Text>{item.EddyStone.BeaconData.txPower->Js.Float.toString->React.string}</Text>
      </View>
    )}
    keyExtractor={(_, i) => Js.Int.toString(i)}
    />
}
