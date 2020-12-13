// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Async from "./Async.bs.js";
import * as Curry from "bs-platform/lib/es6/curry.js";
import * as State from "./State.bs.js";
import * as React from "react";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";
import * as ReactNative from "react-native";
import * as AsyncStorage from "@react-native-community/async-storage";

var stateContext = React.createContext([
      /* Start */0,
      (function (param) {
          
        })
    ]);

function makeProps(value, children, param) {
  return {
          value: value,
          children: children
        };
}

var make = stateContext.Provider;

var StateProvider = {
  stateContext: stateContext,
  makeProps: makeProps,
  make: make
};

function App$StartScreen(Props) {
  var match = React.useContext(stateContext);
  var setAppState = match[1];
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      children: "Start Screen"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* ScanningBeacon */1;
                                      }));
                        }),
                      title: "No beacon paired"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* NoUserStored */4;
                                      }));
                        }),
                      title: "No user data"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* Initializing */9;
                                      }));
                        }),
                      title: "All good to go"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          
                        }),
                      title: "Clear beacon data"
                    })));
}

var StartScreen = {
  make: App$StartScreen
};

var Beacon = {};

function App$PairBeaconScreen(Props) {
  var match = React.useContext(stateContext);
  var setAppState = match[1];
  var appState = match[0];
  var match$1 = React.useState(function () {
        return [{
                  id: "123"
                }];
      });
  var match$2 = React.useState(function () {
        
      });
  var setSelected = match$2[1];
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      children: "Pairing beacon"
                    }), appState === /* ScanningBeacon */1 && Belt_Option.isSome(match$2[0]) ? React.createElement(ReactNative.View, {
                        children: null
                      }, React.createElement(ReactNative.Button, {
                            onPress: (function (param) {
                                return Curry._1(setAppState, (function (param) {
                                              return State.next(/* SaveBeacon */1, param);
                                            }));
                              }),
                            title: "Yes"
                          }), React.createElement(ReactNative.Button, {
                            onPress: (function (param) {
                                return Curry._1(setSelected, (function (param) {
                                              
                                            }));
                              }),
                            title: "No"
                          })) : (
                    appState === /* BeaconPaired */2 ? React.createElement(ReactNative.View, {
                            children: React.createElement(ReactNative.Button, {
                                  onPress: (function (param) {
                                      return Curry._1(setAppState, (function (param) {
                                                    return State.next(/* ConfirmBeaconSaved */2, param);
                                                  }));
                                    }),
                                  title: "Proceed"
                                })
                          }) : null
                  ), React.createElement(ReactNative.FlatList, {
                      data: match$1[0],
                      keyExtractor: (function (beacon, param) {
                          return beacon.id;
                        }),
                      renderItem: (function (param) {
                          var item = param.item;
                          return React.createElement(ReactNative.View, {
                                      children: null,
                                      key: item.id
                                    }, React.createElement(ReactNative.Text, {
                                          children: item.id,
                                          key: item.id
                                        }), React.createElement(ReactNative.Button, {
                                          onPress: (function (param) {
                                              return Curry._1(setSelected, (function (param) {
                                                            return item;
                                                          }));
                                            }),
                                          title: "Select"
                                        }));
                        })
                    })));
}

var PairBeaconScreen = {
  make: App$PairBeaconScreen
};

function App$LoadUserScreen(Props) {
  var match = React.useContext(stateContext);
  var setAppState = match[1];
  var appState = match[0];
  React.useEffect((function () {
          switch (appState) {
            case /* NoUserStored */4 :
                Curry._1(setAppState, (function (param) {
                        return /* DownloadingUser */5;
                      }));
                return ;
            case /* DownloadingUser */5 :
                Curry._1(setAppState, (function (param) {
                        return /* UserJustStored */8;
                      }));
                return ;
            case /* ErrorUserNotFound */6 :
                Curry._1(setAppState, (function (param) {
                        return /* BeaconUnpaired */3;
                      }));
                return ;
            case /* ErrorUserInvalid */7 :
                Curry._1(setAppState, (function (param) {
                        return /* BeaconUnpaired */3;
                      }));
                return ;
            case /* UserJustStored */8 :
                Curry._1(setAppState, (function (param) {
                        return /* Start */0;
                      }));
                return ;
            case /* Start */0 :
            case /* ScanningBeacon */1 :
            case /* BeaconPaired */2 :
            case /* BeaconUnpaired */3 :
            case /* Initializing */9 :
            case /* Monitoring */10 :
            case /* NearbyUserDetected */11 :
            case /* QueryingUser */12 :
            case /* WarningUser */13 :
                return ;
            
          }
        }), [appState]);
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: React.createElement(ReactNative.Text, {
                        children: "Loading user data"
                      })
                }));
}

var LoadUserScreen = {
  make: App$LoadUserScreen
};

function App$MonitorScreen(Props) {
  var match = React.useContext(stateContext);
  var setAppState = match[1];
  var appState = match[0];
  React.useEffect((function () {
          switch (appState) {
            case /* Initializing */9 :
                Curry._1(setAppState, (function (param) {
                        return /* Monitoring */10;
                      }));
                return ;
            case /* NearbyUserDetected */11 :
                Curry._1(setAppState, (function (param) {
                        return /* QueryingUser */12;
                      }));
                return ;
            case /* QueryingUser */12 :
                Curry._1(setAppState, (function (param) {
                        return /* Monitoring */10;
                      }));
                return ;
            case /* Start */0 :
            case /* ScanningBeacon */1 :
            case /* BeaconPaired */2 :
            case /* BeaconUnpaired */3 :
            case /* NoUserStored */4 :
            case /* DownloadingUser */5 :
            case /* ErrorUserNotFound */6 :
            case /* ErrorUserInvalid */7 :
            case /* UserJustStored */8 :
            case /* Monitoring */10 :
            case /* WarningUser */13 :
                return ;
            
          }
        }), [appState]);
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      children: "Monitor"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* NearbyUserDetected */11;
                                      }));
                        }),
                      title: "Nearby found"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* WarningUser */13;
                                      }));
                        }),
                      title: "Danger found"
                    })));
}

var MonitorScreen = {
  make: App$MonitorScreen
};

function App$WarnScreen(Props) {
  var match = React.useContext(stateContext);
  var setAppState = match[1];
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      children: "Warning!"
                    }), React.createElement(ReactNative.Button, {
                      onPress: (function (param) {
                          return Curry._1(setAppState, (function (param) {
                                        return /* Monitoring */10;
                                      }));
                        }),
                      title: "No danger anymore"
                    })));
}

var WarnScreen = {
  make: App$WarnScreen
};

function App$AppView(Props) {
  var match = React.useContext(stateContext);
  var tmp;
  var exit = 0;
  switch (match[0]) {
    case /* Start */0 :
        tmp = React.createElement(App$StartScreen, {});
        break;
    case /* ScanningBeacon */1 :
    case /* BeaconPaired */2 :
    case /* BeaconUnpaired */3 :
        exit = 1;
        break;
    case /* NoUserStored */4 :
    case /* DownloadingUser */5 :
    case /* ErrorUserNotFound */6 :
    case /* ErrorUserInvalid */7 :
    case /* UserJustStored */8 :
        exit = 2;
        break;
    case /* Initializing */9 :
    case /* Monitoring */10 :
    case /* NearbyUserDetected */11 :
    case /* QueryingUser */12 :
        exit = 3;
        break;
    case /* WarningUser */13 :
        tmp = React.createElement(App$WarnScreen, {});
        break;
    
  }
  switch (exit) {
    case 1 :
        tmp = React.createElement(App$PairBeaconScreen, {});
        break;
    case 2 :
        tmp = React.createElement(App$LoadUserScreen, {});
        break;
    case 3 :
        tmp = React.createElement(App$MonitorScreen, {});
        break;
    
  }
  return React.createElement(React.Fragment, undefined, tmp);
}

var AppView = {
  make: App$AppView
};

function App$app(Props) {
  var match = React.useState(function () {
        return /* Start */0;
      });
  Async.then_(AsyncStorage.default.setItem("foo", "bar"), (function (param) {
          return Async.async((console.log("woot"), undefined));
        }));
  return React.createElement(React.Fragment, undefined, React.createElement(make, makeProps([
                      match[0],
                      match[1]
                    ], React.createElement(App$AppView, {}), undefined)));
}

var app = App$app;

export {
  StateProvider ,
  StartScreen ,
  Beacon ,
  PairBeaconScreen ,
  LoadUserScreen ,
  MonitorScreen ,
  WarnScreen ,
  AppView ,
  app ,
  
}
/* stateContext Not a pure module */
