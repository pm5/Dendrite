// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Decco from "decco/src/Decco.bs.js";
import * as Js_dict from "bs-platform/lib/es6/js_dict.js";
import * as Js_json from "bs-platform/lib/es6/js_json.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";

function t_encode(v) {
  return Js_dict.fromArray([
              [
                "distance",
                Decco.floatToJson(v.distance)
              ],
              [
                "major",
                Decco.intToJson(v.major)
              ],
              [
                "minor",
                Decco.intToJson(v.minor)
              ],
              [
                "proximity",
                Decco.stringToJson(v.proximity)
              ],
              [
                "rssi",
                Decco.intToJson(v.rssi)
              ],
              [
                "uuid",
                Decco.stringToJson(v.uuid)
              ]
            ]);
}

function t_decode(v) {
  var dict = Js_json.classify(v);
  if (typeof dict === "number") {
    return Decco.error(undefined, "Not an object", v);
  }
  if (dict.TAG !== /* JSONObject */2) {
    return Decco.error(undefined, "Not an object", v);
  }
  var dict$1 = dict._0;
  var distance = Decco.floatFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "distance"), null));
  if (distance.TAG === /* Ok */0) {
    var major = Decco.intFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "major"), null));
    if (major.TAG === /* Ok */0) {
      var minor = Decco.intFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "minor"), null));
      if (minor.TAG === /* Ok */0) {
        var proximity = Decco.stringFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "proximity"), null));
        if (proximity.TAG === /* Ok */0) {
          var rssi = Decco.intFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "rssi"), null));
          if (rssi.TAG === /* Ok */0) {
            var uuid = Decco.stringFromJson(Belt_Option.getWithDefault(Js_dict.get(dict$1, "uuid"), null));
            if (uuid.TAG === /* Ok */0) {
              return {
                      TAG: /* Ok */0,
                      _0: {
                        distance: distance._0,
                        major: major._0,
                        minor: minor._0,
                        proximity: proximity._0,
                        rssi: rssi._0,
                        uuid: uuid._0
                      }
                    };
            }
            var e = uuid._0;
            return {
                    TAG: /* Error */1,
                    _0: {
                      path: ".uuid" + e.path,
                      message: e.message,
                      value: e.value
                    }
                  };
          }
          var e$1 = rssi._0;
          return {
                  TAG: /* Error */1,
                  _0: {
                    path: ".rssi" + e$1.path,
                    message: e$1.message,
                    value: e$1.value
                  }
                };
        }
        var e$2 = proximity._0;
        return {
                TAG: /* Error */1,
                _0: {
                  path: ".proximity" + e$2.path,
                  message: e$2.message,
                  value: e$2.value
                }
              };
      }
      var e$3 = minor._0;
      return {
              TAG: /* Error */1,
              _0: {
                path: ".minor" + e$3.path,
                message: e$3.message,
                value: e$3.value
              }
            };
    }
    var e$4 = major._0;
    return {
            TAG: /* Error */1,
            _0: {
              path: ".major" + e$4.path,
              message: e$4.message,
              value: e$4.value
            }
          };
  }
  var e$5 = distance._0;
  return {
          TAG: /* Error */1,
          _0: {
            path: ".distance" + e$5.path,
            message: e$5.message,
            value: e$5.value
          }
        };
}

function toString(beacon) {
  return Belt_Option.getExn(JSON.stringify(beacon));
}

function fromString(str) {
  var beacon = t_decode(JSON.parse(str));
  if (beacon.TAG === /* Ok */0) {
    return beacon._0;
  }
  
}

function toCitizenId(beacon) {
  return String(beacon.minor);
}

export {
  t_encode ,
  t_decode ,
  toString ,
  fromString ,
  toCitizenId ,
  
}
/* No side effect */
