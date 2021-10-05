import 'package:hive/hive.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:oxidized/oxidized.dart';

   const String NEW_USER = 'newuser';
   const String  COURSES_VERSION = 'coursesversion';
   const String  DARK_MODE = 'darkmode';

class HiveSettingsLocalDataSource {
  
  //returns true if new user
  Future<Result<bool, AppException>> checkIfNewUser() async {
    try {
      final settingsBox = await Hive.openBox('settingsBox');
      bool isNewUser = await settingsBox.get(NEW_USER, defaultValue: true); //if newUser doesnt exist then its first time user
      return Ok(isNewUser);
    } catch (e) {
      print("Error: HiveSettingsLocalDataSource: checkIfNewUser(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }

  //get version number of cached courses
  Future<Result<int, AppException>> getCoursesVersion() async {
    try {
      final settingsBox = await Hive.openBox('settingsBox');
      int coursesVersion = await settingsBox.get(COURSES_VERSION, defaultValue: 1); //if not courses version, default minimum version is 1
      return Ok(coursesVersion);
    } catch (e) {
      print("Error: HiveSettingsLocalDataSource: getCoursesVersion(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }

  //set newUser to false
  Future<Result<void, AppException>> setNotNewUser() async {
    try {
      final settingsBox = await Hive.openBox('settingsBox');
      final result = await settingsBox.put(NEW_USER, false);
      return Ok(result);
    } catch (e) {
      print("Error: HiveSettingsLocalDataSource: getCoursesVersion(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }

  //check if dark mode or light mode
  Future<Result<bool, AppException>> checkIfDarkMode() async {
    try {
      final settingsBox = await Hive.openBox('settingsBox');
      bool? isDarkMode = await settingsBox.get(DARK_MODE);
      if(isDarkMode == null){
        print("isDarkMode value in box empty");
        isDarkMode = false;
      }
      return Ok(isDarkMode);
    } catch (e) {
      print("Error: HiveSettingsLocalDataSource: checkIfDarkMode(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }

  //toggle theme dark/light
  Future<Result<void, AppException>> toggleThemeMode() async {
    try {
      final settingsBox = await Hive.openBox('settingsBox');
      bool darkMode = await settingsBox.get(DARK_MODE, defaultValue: false);
      final result = await settingsBox.put(DARK_MODE, !darkMode); //toggle darkMode value
      return Ok(result);
    } catch (e) {
      print("Error: HiveSettingsLocalDataSource: toggleThemeMode(): $e");
      return Err(AppException(type: AppExceptionType.database));
    }
  }
}
