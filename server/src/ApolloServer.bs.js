// Generated by BUCKLESCRIPT, PLEASE EDIT WITH CARE
'use strict';

var ApolloServer = require("apollo-server");
var Js_null_undefined = require("bs-platform/lib/js/js_null_undefined.js");

function Make(R) {
  var createApolloServer = function (options, typeDefs, resolvers, engine, param) {
    return new ApolloServer.ApolloServer({
                options: Js_null_undefined.fromOption(options),
                typeDefs: Js_null_undefined.fromOption(typeDefs),
                resolvers: Js_null_undefined.fromOption(resolvers),
                engine: Js_null_undefined.fromOption(engine)
              });
  };
  return {
          createApolloServer: createApolloServer
        };
}

exports.Make = Make;
/* apollo-server Not a pure module */
