import 'package:expense_tracker_app/features/auth/data/models/user_model.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  static UserModel? _userData;

  Future<void> setUserData(UserModel? userData) async {
    _userData = userData;
  }

  Future<UserModel?> getUserData() async {
    return _userData;
  }
}
