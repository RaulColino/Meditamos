import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meditamos/data/datasources/sanity/graphql_sanity_config.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/entities/news.dart';
import 'package:oxidized/oxidized.dart';

class SanityNewsRemoteDatasource {
  final GraphQLClient _client = GraphQLSanityConfig().client;

  //get courses from Sanity API using GraphQL endpoint
  Future<Result<List<News>, AppException>> getNews() async {
    try {
      const query = '''
query {
  allAnnouncement(sort: {publishedAt: DESC}){
    _id
    title
    color
    coverImageUrl
    body
  }
}
      ''';
      QueryResult result = await _client.query(QueryOptions(document: gql(query)));
      if (result.hasException) {
        print("Error: getNews(): SanityNewsRemoteDatasource: ${result.exception.toString()}");
        throw SocketException("connection exception");
      }
      var response = result.data;
      print("getNews(): SanityNewsRemoteDatasource: ${response.toString()}");
      print("voy a recorrer array allAnnouncement:");
      List<News> list = [
        for (var nw in response!["allAnnouncement"]) getNewsFromJson(nw),
      ];
      return Ok(list);
    } on SocketException catch (e) {
      print("Error: SanityNewsRemoteDatasource: getNews $e");
      return Err(
          AppException(type: AppExceptionType.network)); //no internet error
    } on Exception catch (e) {
      print("Error: SanityNewsRemoteDatasource: $e");
      return Err(AppException(type: AppExceptionType.api));
    }
  }

  News getNewsFromJson(dynamic nw) {
    print("antes de crear una news"); 
    News news = News(
      newsId: nw["_id"],
      title: nw["title"],
      color: nw["color"],
      coverImageUrl: nw["coverImageUrl"],
      description: nw["body"],
    );
    print("asdfsdgsfgf: ${news.title} dsfdsfdf: ${news.toString()}");
    return news;
  }
}
