import 'package:task_manager/src/core/utils/managers/database/database_manager.dart';

class AppSettings {
  final DatabaseManager databaseManager;
  String? _apiBaseUrl;
  bool? _hasConnection;

  AppSettings({required this.databaseManager});

  //* API Base Url
  String? get apiBaseUrl => _apiBaseUrl;

  set apiBaseUrl(String? value) => _apiBaseUrl = value;

  //* Has Connection
  bool? get hasConnection => _hasConnection;

  set hasConnection(bool? value) => _hasConnection = value;

  //* Token
  String? get token {
    String? result = databaseManager.getData('token');
    return result;
  }

  set token(String? value) {
    databaseManager.saveData("token", value);
  }

  //* Token
  String? get userId {
    String? result = databaseManager.getData('userID');
    return result;
  }

  set userId(String? value) {
    databaseManager.saveData("userID", value);
  }
}
