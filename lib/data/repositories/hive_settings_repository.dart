import 'package:meditamos/data/datasources/hive/hive_settings_local_datasource.dart';
import 'package:meditamos/domain/entities/app_exception.dart';
import 'package:meditamos/domain/repositories/i_settings_repository.dart';
import 'package:oxidized/oxidized.dart';

class HiveSettingsRepository implements ISettingsRepository {
  HiveSettingsLocalDataSource _hiveSettingsLocalDataSource;

  //constructor
  HiveSettingsRepository(this._hiveSettingsLocalDataSource);

  @override
  Future<Result<bool, AppException>> checkIfDarkMode() async {
    return await _hiveSettingsLocalDataSource.checkIfDarkMode();
  }

  @override
  Future<Result<void, AppException>>toggleThemeMode() async {
    return await _hiveSettingsLocalDataSource.toggleThemeMode();
  }

  @override
  Future<Result<bool, AppException>> checkIfNewUser() async {
    return await _hiveSettingsLocalDataSource.checkIfNewUser();
  }

  @override
  Future<Result<int, AppException>> getCoursesVersion() async {
    return await _hiveSettingsLocalDataSource.getCoursesVersion();
  }

  @override
  Future<Result<void, AppException>> setNotNewUser() async {
    return await _hiveSettingsLocalDataSource.setNotNewUser();
  }
}
