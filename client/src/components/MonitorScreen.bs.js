// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as ReactNative from "react-native";
import * as StateProvider from "../StateProvider.bs.js";

function MonitorScreen(Props) {
  var match = React.useContext(StateProvider.stateContext);
  var setAppState = match[1];
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      children: "Monitor"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* NearbyUserDetected */2;
                                      }));
                        }),
                      title: "Nearby found"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* WarningUser */4;
                                      }));
                        }),
                      title: "Danger found"
                    })));
}

var make = MonitorScreen;

export {
  make ,
  
}
/* react Not a pure module */
