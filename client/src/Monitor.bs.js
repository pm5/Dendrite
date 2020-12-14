// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as Neighbor from "./core/Neighbor.bs.js";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.js";

var samples = [{
    citizen: {
      id: "012",
      infections: [],
      vaccinations: [],
      immunities: []
    },
    distanceInMeters: 3.0,
    measuredAt: new Date()
  }];

function useMonitor(user) {
  var match = React.useState(function () {
        return [];
      });
  var setNeighbors = match[1];
  var neighbors = match[0];
  var match$1 = React.useState(function () {
        
      });
  var setDanger = match$1[1];
  React.useEffect((function () {
          var dangers = Neighbor.dangeredBy(user, neighbors);
          if (dangers.length !== 0) {
            Curry._1(setDanger, (function (param) {
                    return Belt_Array.get(dangers, 0);
                  }));
          }
          return (function (param) {
                    return Curry._1(setDanger, (function (param) {
                                  
                                }));
                  });
        }), [neighbors]);
  React.useEffect((function () {
          var job = setInterval((function (param) {
                  return Curry._1(setNeighbors, (function (param) {
                                return samples;
                              }));
                }), 10000);
          return (function (param) {
                    clearInterval(job);
                    
                  });
        }), []);
  return [
          neighbors,
          match$1[0]
        ];
}

export {
  samples ,
  useMonitor ,
  
}
/* samples Not a pure module */