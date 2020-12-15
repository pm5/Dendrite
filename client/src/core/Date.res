type t = Js.Date.t
let t_decode = json =>
  Decco.stringFromJson(json)->Belt.Result.map(Js.Date.fromString)
let t_encode = date =>
  date->Js.Date.toJSONUnsafe->Decco.stringToJson
