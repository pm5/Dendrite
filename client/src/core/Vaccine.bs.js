// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Decco from "decco/src/Decco.bs.js";
import * as Js_dict from "bs-platform/lib/es6/js_dict.js";
import * as Js_json from "bs-platform/lib/es6/js_json.js";
import * as Belt_Option from "bs-platform/lib/es6/belt_Option.js";

function t_encode(v) {
  return Js_dict.fromArray([[
                "name",
                Decco.stringToJson(v.name)
              ]]);
}

function t_decode(v) {
  var dict = Js_json.classify(v);
  if (typeof dict === "number") {
    return Decco.error(undefined, "Not an object", v);
  }
  if (dict.TAG !== /* JSONObject */2) {
    return Decco.error(undefined, "Not an object", v);
  }
  var name = Decco.stringFromJson(Belt_Option.getWithDefault(Js_dict.get(dict._0, "name"), null));
  if (name.TAG === /* Ok */0) {
    return {
            TAG: /* Ok */0,
            _0: {
              name: name._0
            }
          };
  }
  var e = name._0;
  return {
          TAG: /* Error */1,
          _0: {
            path: ".name" + e.path,
            message: e.message,
            value: e.value
          }
        };
}

export {
  t_encode ,
  t_decode ,
  
}
/* No side effect */
