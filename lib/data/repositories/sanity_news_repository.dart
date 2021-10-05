import 'package:meditamos/data/datasources/hive/hive_course_local_datasource.dart';
import 'package:meditamos/data/datasources/sanity/sanity_news_remote_datasource.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/entities/news.dart';
import 'package:meditamos/domain/repositories/i_news_repository.dart';
import 'package:oxidized/oxidized.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SanityNewsRepository extends INewsRepository {

  final SanityNewsRemoteDatasource _sanityNewsRemoteDatasource;

  SanityNewsRepository(this._sanityNewsRemoteDatasource);

  @override
  Future<Result<List<News>, AppException>> getNews() async {
    
/*     final internetAvailable = await InternetConnectionChecker().hasConnection;
    if (internetAvailable) {
      //if connection available get courses from API
      final newsResult = await _sanityNewsRemoteDatasource.getNews();
      print("SanityNewsRepository: getNews(): got news from API.");
      //saveResult.unwrap(); //throws Err() if saveResult() failed
      return newsResult; //finally return courses
    } else {
      //otherwise we must show an error
      print("SanityNewsRepository: getNews(): No internet connection.");
      return Err(AppException(type:AppExceptionType.network,msg: "no connection"));
    } */

    final newsResult = await _sanityNewsRemoteDatasource.getNews();
    //print("aaaaaaaaaaaaaa: "+newsResult.toString());
    return newsResult;
  }
}
