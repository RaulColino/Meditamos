import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meditamos/data/datasources/sanity/graphql_sanity_config.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/entities/course.dart';
import 'package:meditamos/domain/entities/course_component.dart';
import 'package:oxidized/oxidized.dart';

/* abstract class ICourseRemoteDatasource {
  Future<Result<List<Course>, AppException>> getCourses(int page);
  Future<Result<bool, AppException>> isLatestVersion(int version);
} 

class SanityCourseRemoteDatasource implements ICourseRemoteDatasource {*/
class SanityCourseRemoteDatasource {
  final GraphQLClient _client = GraphQLSanityConfig().client;

  //get courses from Sanity API using GraphQL endpoint
  Future<Result<List<Course>, AppException>> getCourses() async {
    try {
      const query = '''
        query {
          allCourse(sort: {title: ASC}) {
            _id
            title
            coverImageUrl
            contents {
              ... on Audio {
                _type
                name
                imageUrl
                audioUrl
              }
              ... on Video {
                _type
                title
                videoId
              }
            }
          }
        }
      ''';
      QueryResult result = await _client.query(QueryOptions(document: gql(query)));
      if (result.hasException) {
        throw AppException(type: AppExceptionType.api);
      }
      var response = result.data;
      //print("getCourses(): SanityCourseRemoteDatasource: ${response.toString()}");
      /* final map = response as Map<String, dynamic>;
      Data mappedResult = Data.fromJson(map);
      return mappedResult; */
      List<Course> list = [
        for (var c in response!["allCourse"]) getCourseFromJson(c),
      ];
      return Ok(list);
    } on SocketException catch (e) {
      print("Error: SanityCourseRemoteDatasource: getCourses $e");
      return Err(AppException(type: AppExceptionType.network)); //no internet error
    } on Exception catch (e) {
      print("Error: SanityCourseRemoteDatasource: $e");
      return Err(AppException(type: AppExceptionType.api));
    }
  }

  //check courselist version updates
  Future<Result<bool, AppException>> isLatestVersion(int version) async {
    try {
      return Ok(true);
    } on SocketException {
      return Err(
          AppException(type: AppExceptionType.network)); //no internet error
    } on Exception {
      return Err(AppException(type: AppExceptionType.api));
    }
  }

  Course getCourseFromJson(dynamic c) {
     
    //Course: ${c.toString()}
    print("SanityCourseRemoteDatasource:  has field values: courseId: ${c["_id"]}, title: ${c["title"]}, coverImageUrl: ${c["coverImageUrl"]}, contents: ${c["contents"].toString()}");
    print("\n");
    List<CourseComponent> courseContents = [];
   try {
     courseContents = c["contents"]
      .map((comp) => (comp["_type"] == "audio")
            ? 
                CourseAudioComponent(
                  type: comp["_type"],
                  name: comp["name"],
                  imageUrl: comp["imageUrl"],
                  audioUrl: comp["audioUrl"],
                )
             
            : 
                CourseVideoComponent(
                  type: comp["_type"],
                  title: comp["title"],
                  videoId: comp["videoId"],
                ))

      .cast<CourseComponent>()
      .toList(); 
      
             
      print("SanityCourseRemoteDatasource: course component added: contents: ${courseContents.toString()}");
    } catch (e) {
      print("SanityCourseRemoteDatasource: PARSING error: $e");
    }
    Course course = Course(
      courseId: c["_id"],
      title: c["title"],
      coverImageUrl: c["coverImageUrl"],
      contents: courseContents,
    );
    print("SanityCourseRemoteDatasource: Course created with contents!: ${course.contents.toString()}");
    return course;
  }
}


