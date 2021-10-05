import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/entities/course.dart';
import 'package:oxidized/oxidized.dart';

class HiveCourseLocalDatasource {
  static const String COURSES = "courses";

  Future<Result<void, AppException>> saveCourses(List<Course> courses) async {
    try {
      final coursesBox = await Hive.openBox('coursesBox');
      coursesBox.put(
        COURSES,
        jsonEncode(courses.map((course) {
          final jsonCourse = course.toJson();
          print("HiveCourseLocalDatasource:::::::::::::::::: $jsonCourse");
          return jsonCourse;
        }).toList()),
      );
      return Ok(null);
    } catch (e) {
      print("Error: HiveCourseLocalDatasource: save(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }

  Future<Result<List<Course>, AppException>> getCourses() async {
    try {
      final coursesBox = await Hive.openBox('coursesBox');
      final coursesJsonString = coursesBox.get(COURSES, defaultValue: null);
      if (coursesJsonString == null)
        return Err(AppException(type: AppExceptionType.network));
      //print("HiveCourseLocalDatasource: map from jsonDecode: ${jsonDecode(coursesJsonString)}");
      final courses = json.decode(coursesJsonString);
      print("json decode : $courses");
      final listCourses = courses.map<Course>((c) {
            print("maped course from map: $c");
            //final Map<String,dynamic> cc = c.cast<Map<String,dynamic>>();
              //print("casted course from map: $cc");
             final cf = Course.fromJson(c);
             print("cf: $cf");
             return cf;
          })
          .toList();
      print("HiveCourseLocalDatasource: getCourses: list of courses gotten: $listCourses");
      // List<Course>.from(jsonDecode(coursesJson).map((c)=>Course.fromMap(c)));
      //jsonDecode(coursesJson).map((courseJson) => Course.fromJson(courseJson));
      return Ok(listCourses);
    } catch (e,st) {
      print("Error: HiveCourseLocalDatasource: getCourses(): $e. stacktrace: $st");
      return Err(AppException(type: AppExceptionType.database));
    }
  }
}
