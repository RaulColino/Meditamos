import 'package:meditamos/data/datasources/hive/hive_course_local_datasource.dart';
import 'package:meditamos/data/datasources/sanity/sanity_course_remote_datasource.dart';
import 'package:meditamos/domain/entities/course.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/repositories/i_course_repository.dart';
import 'package:oxidized/oxidized.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SanityHiveCourseRepository extends ICourseRepository {
  final SanityCourseRemoteDatasource _sanityCourseRemoteDatasource;
  final HiveCourseLocalDatasource _hiveCourseLocalDatasource;

  SanityHiveCourseRepository(this._sanityCourseRemoteDatasource, this._hiveCourseLocalDatasource);

  @override
  Future<Result<List<Course>, AppException>> getCourses() async {
    final internetAvailable = await InternetConnectionChecker().hasConnection;
    if (internetAvailable) {
      //if connection available get courses from API
      final coursesResult = await _sanityCourseRemoteDatasource.getCourses();
      print("SanityHiveCourseRepository: getCourses(): got courses from API. Saving courses into local storage...");
      final saveResult = await _hiveCourseLocalDatasource.saveCourses(coursesResult.unwrap()); //unwrap throw err() automatically if error
      print("SanityHiveCourseRepository: getCourses(): Courses saved into local storage succesfully");
      //saveResult.unwrap(); //throws Err() if saveResult() failed
      return coursesResult; //finally return courses
    } else {
      //otherwise get cached courses
      print("SanityHiveCourseRepository: getCourses(): No internet connection. Getting courses from local storage");
      return await _hiveCourseLocalDatasource.getCourses();
    }
  }

















/*   @override
  Future<Result<List<Course>, AppException>> getCourses() async {
    final internetAvailable = await InternetConnectionChecker().hasConnection;
    if (internetAvailable) {
      //if connection available get courses from API
      final coursesResult = await _sanityCourseRemoteDatasource.getCourses();
      final saveResult = await _hiveCourseLocalDatasource.save(coursesResult.unwrap()); //unwrap throw err() automatically if error
      return coursesResult;
    } else {
      //otherwise get cached courses
      return await _hiveCourseLocalDatasource.getCourses();
    }
  } */
}
