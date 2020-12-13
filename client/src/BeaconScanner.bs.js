// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as BeaconList from "./BeaconList.bs.js";
import * as ReactNative from "react-native";
import * as ReactNativeEddystone from "@lg2/react-native-eddystone";

function useScanner(param) {
  var match = React.useState(function () {
        return false;
      });
  var scanning = match[0];
  var match$1 = React.useState(function () {
        return {
                beacons: [{
                    id: "0",
                    uid: "0x00",
                    rssi: 0.1,
                    txPower: 0.01
                  }]
              };
      });
  var setBeacons = match$1[1];
  var beaconListener = function (d) {
    console.log("wooty");
    return Curry._1(setBeacons, (function (beacons) {
                  return {
                          beacons: [d].concat(beacons.beacons).slice(0, 10)
                        };
                }));
  };
  React.useEffect((function () {
          console.log("woot");
          ReactNativeEddystone.default.addListener("onUIDFrame", beaconListener);
          ReactNativeEddystone.default.startScanning();
          return (function (param) {
                    ReactNativeEddystone.default.stopScanning();
                    ReactNativeEddystone.default.removeListener("onUIDFrame", beaconListener);
                    console.log("uoot");
                    
                  });
        }), [scanning]);
  return [
          match$1[0],
          scanning,
          match[1]
        ];
}

function BeaconScanner(Props) {
  var match = useScanner(undefined);
  var setScanning = match[2];
  return React.createElement(ReactNative.View, {
              children: null
            }, React.createElement(BeaconList.make, {
                  data: match[0].beacons
                }), React.createElement(ReactNative.Button, {
                  onPress: (function (param) {
                      return Curry._1(setScanning, (function (s) {
                                    return !s;
                                  }));
                    }),
                  title: match[1] ? "Stop" : "Start"
                }));
}

var make = BeaconScanner;

export {
  useScanner ,
  make ,
  
}
/* react Not a pure module */
