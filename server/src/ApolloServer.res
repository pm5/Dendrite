module type Resolvers = {
  type t
}

module Make = (R: Resolvers) => {
  type queryString

  type graphqlServer

  type gql_ = string => queryString

  type options

  type response = { url: string }

  type apolloServerProps = {
    options: Js.nullable<options>,
    typeDefs: Js.nullable<queryString>,
    resolvers: Js.nullable<R.t>,
    engine: Js.nullable<bool>,
  }

  type listenProps = { port: int }

  @bs.module("apollo-server")
  external gql: gql_ = "gql"

  @bs.module("apollo-server") @bs.new
  external makeApolloServer: apolloServerProps => graphqlServer = "ApolloServer"

  @bs.send
  external listen: (graphqlServer, listenProps) => Js.Promise.t<'a> = "listen"

  let createApolloServer =
      (~options=?, ~typeDefs=?, ~resolvers=?, ~engine=?, ()) => {
    makeApolloServer({
      options: Js.Nullable.fromOption(options),
      typeDefs: Js.Nullable.fromOption(typeDefs),
      resolvers: Js.Nullable.fromOption(resolvers),
      engine: Js.Nullable.fromOption(engine),
    })
  }
}
