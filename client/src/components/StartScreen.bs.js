// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Logo from "./Logo.bs.js";
import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as ReactNative from "react-native";
import * as StateProvider from "../StateProvider.bs.js";

function StartScreen(Props) {
  var match = React.useContext(StateProvider.stateContext);
  var setAppState = match[1];
  return React.createElement(ReactNative.View, {
              children: null
            }, React.createElement(Logo.make, {}), React.createElement(ReactNative.Button, {
                  onPress: (function (param) {
                      return Curry._1(setAppState, (function (param) {
                                    return /* ScanningBeacon */2;
                                  }));
                    }),
                  title: "Start"
                }));
}

var make = StartScreen;

export {
  make ,
  
}
/* Logo Not a pure module */
