// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Logo from "./Logo.bs.js";
import * as Async from "../Async.bs.js";
import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as Monitor from "../Monitor.bs.js";
import * as $$Storage from "../Storage.bs.js";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";
import * as ScreenStyle from "../styles/ScreenStyle.bs.js";
import * as ReactNative from "react-native";
import * as StateProvider from "../StateProvider.bs.js";
import * as Caml_splice_call from "bs-platform/lib/es6/caml_splice_call.js";

var styles = ReactNative.StyleSheet.create({
      warning: {
        color: "#fff",
        fontSize: 18,
        fontWeight: "bold",
        textAlign: "center",
        backgroundColor: "#f00",
        padding: 6
      },
      danger: {
        color: "#fff",
        fontSize: 18,
        fontWeight: "bold",
        textAlign: "center",
        padding: 6
      }
    });

function reset(setAppState) {
  Async.then_(Async.then_($$Storage.resetBeacon(undefined), (function (param) {
              return $$Storage.resetUser(undefined);
            })), (function (param) {
          return Async.async(Curry._1(setAppState, (function (param) {
                            return /* Start */0;
                          })));
        }));
  
}

function MonitorScreen$WarnScreen(Props) {
  var neighbor = Props.neighbor;
  var pathogen = Props.pathogen;
  ReactNative.Vibration.vibrate(100, undefined);
  return React.createElement(ReactNative.View, {
              children: null
            }, React.createElement(ReactNative.Text, {
                  style: styles.warning,
                  children: "Warning"
                }), React.createElement(ReactNative.Text, {
                  style: styles.danger,
                  children: pathogen.name + ": within " + String((neighbor.distanceInMeters * 10 | 0) / 10) + " meter(s)"
                }), Belt_Option.getWithDefault(Belt_Option.map(Belt_Array.get(neighbor.citizen.photo, 0), (function (photo) {
                        return React.createElement(ReactNative.Image, {
                                    resizeMode: "cover",
                                    source: {
                                      uri: photo.thumbnail.url
                                    },
                                    style: {
                                      height: photo.thumbnail.height,
                                      width: photo.thumbnail.width
                                    }
                                  });
                      })), null));
}

var WarnScreen = {
  make: MonitorScreen$WarnScreen
};

function MonitorScreen(Props) {
  var user = Props.user;
  StateProvider.useContext(undefined);
  var match = Monitor.useMonitor(user);
  var danger = match[1];
  var match$1 = React.useState(function () {
        return 1;
      });
  var setCount = match$1[1];
  React.useEffect((function () {
          var task = setInterval((function (param) {
                  return Curry._1(setCount, (function (c) {
                                if (c > 20) {
                                  return 1;
                                } else {
                                  return c + 1 | 0;
                                }
                              }));
                }), 1200);
          return (function (param) {
                    clearInterval(task);
                    
                  });
        }), []);
  return React.createElement(React.Fragment, undefined, danger !== undefined ? React.createElement(MonitorScreen$WarnScreen, {
                    neighbor: danger[0],
                    pathogen: danger[1]
                  }) : React.createElement(ReactNative.View, {
                    children: null
                  }, React.createElement(Logo.make, {}), React.createElement(ReactNative.Text, {
                        style: [
                          ScreenStyle.styles.text,
                          {
                            padding: 8
                          }
                        ],
                        children: "Monitoring" + Caml_splice_call.spliceObjApply("", "concat", [Belt_Array.make(match$1[0], ".")])
                      })));
}

var make = MonitorScreen;

export {
  styles ,
  reset ,
  WarnScreen ,
  make ,
  
}
/* styles Not a pure module */
