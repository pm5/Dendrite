// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Pervasives from "bs-platform/lib/es6/pervasives.js";

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

function useContext(param) {
  return React.useContext(stateContext);
}

function take(action, currentState) {
  if (typeof action !== "number") {
    if (action.TAG === /* SaveBeacon */0) {
      if (typeof currentState === "number" && currentState !== 0) {
        return {
                TAG: /* BeaconSaved */2,
                _0: action._0
              };
      } else {
        return Pervasives.failwith("Invalid action at current state");
      }
    } else if (typeof currentState === "number" || currentState.TAG !== /* LoadingUser */3) {
      return Pervasives.failwith("Invalid action at current state");
    } else {
      return {
              TAG: /* UserLoaded */1,
              _0: currentState._0,
              _1: action._0
            };
    }
  }
  switch (action) {
    case /* PairBeacon */0 :
        if (typeof currentState === "number" && currentState === 0) {
          return /* ScanningBeacon */1;
        } else {
          return Pervasives.failwith("Invalid action at current state");
        }
    case /* ConfirmBeaconSaved */1 :
        if (typeof currentState === "number" || currentState.TAG !== /* BeaconSaved */2) {
          return Pervasives.failwith("Invalid action at current state");
        } else {
          return {
                  TAG: /* BeaconPaired */0,
                  _0: currentState._0
                };
        }
    case /* LoadUser */2 :
        if (typeof currentState === "number" || currentState.TAG !== /* BeaconPaired */0) {
          return Pervasives.failwith("Invalid action at current state");
        } else {
          return {
                  TAG: /* LoadingUser */3,
                  _0: currentState._0
                };
        }
    case /* StartMonitor */3 :
        if (typeof currentState === "number") {
          return Pervasives.failwith("Invalid action at current state");
        }
        switch (currentState.TAG | 0) {
          case /* UserLoaded */1 :
          case /* Monitoring */4 :
              return {
                      TAG: /* Monitoring */4,
                      _0: currentState._0,
                      _1: currentState._1
                    };
          default:
            return Pervasives.failwith("Invalid action at current state");
        }
    
  }
}

export {
  stateContext ,
  makeProps ,
  make ,
  useContext ,
  take ,
  
}
/* stateContext Not a pure module */
