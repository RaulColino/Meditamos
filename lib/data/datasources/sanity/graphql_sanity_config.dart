//graphql_flutter
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLSanityConfig {
  //static String token = "your can get it from a secured storage";
  static final HttpLink httpLink = HttpLink(
    "your sanity link here",
  );
  /*static final _authLink = AuthLink(getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',);
  Link _link = _authLink.concat(_httpLink);*/
  GraphQLClient get client {
    return GraphQLClient(
      link: httpLink,
      cache:
          GraphQLCache(), // The default store is the InMemoryStore, which does NOT persist to disk. This is what we use because we do custom caching.
    );
  }
}