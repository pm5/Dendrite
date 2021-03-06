// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";
import * as ScreenStyle from "../styles/ScreenStyle.bs.js";
import * as ReactNative from "react-native";

function UserStatus$ImmunityRow(Props) {
  var immunity = Props.immunity;
  return React.createElement(ReactNative.Text, {
              style: ScreenStyle.styles.text,
              children: immunity.antibody.name
            });
}

var ImmunityRow = {
  make: UserStatus$ImmunityRow
};

function UserStatus$InfectionRow(Props) {
  var infection = Props.infection;
  return React.createElement(ReactNative.Text, {
              style: ScreenStyle.styles.text,
              children: infection.pathogen.name
            });
}

var InfectionRow = {
  make: UserStatus$InfectionRow
};

function UserStatus(Props) {
  var user = Props.user;
  return React.createElement(React.Fragment, undefined, React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      style: ScreenStyle.styles.text,
                      children: "Your immunities"
                    }), React.createElement(ReactNative.ScrollView, {
                      children: Belt_Array.mapWithIndex(user.immunities, (function (index, immunity) {
                              return React.createElement(UserStatus$ImmunityRow, {
                                          immunity: immunity,
                                          key: String(index)
                                        });
                            }))
                    })), React.createElement(ReactNative.View, {
                  children: null
                }, React.createElement(ReactNative.Text, {
                      style: ScreenStyle.styles.text,
                      children: "Your infections"
                    }), React.createElement(ReactNative.ScrollView, {
                      children: Belt_Array.mapWithIndex(user.infections, (function (index, infection) {
                              return React.createElement(UserStatus$InfectionRow, {
                                          infection: infection,
                                          key: String(index)
                                        });
                            }))
                    })));
}

var make = UserStatus;

export {
  ImmunityRow ,
  InfectionRow ,
  make ,
  
}
/* react Not a pure module */
