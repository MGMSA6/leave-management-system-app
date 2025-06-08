import 'package:manam_leave_management/domain/entities/holiday_entity.dart';
import 'package:manam_leave_management/domain/entities/login_entity.dart';

import '../../domain/entities/current_user_application_entity.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  SessionManager._internal();

  String? _authToken;
  LoginEntity? _user;
  CurrentUserApplicationEntity? _applications;
  List<HolidayEntity>? _holidayEntity;
  bool? _isLoggedIn;

  LoginEntity? get user => _user;

  CurrentUserApplicationEntity? get applications => _applications;

  List<HolidayEntity>? get holidayEntity => _holidayEntity;

  bool? get isLoggedIn => _isLoggedIn;

  String? get authToken => _authToken;

  void setAuthToken(String token) {
    _authToken = token;
  }
  
  void setUser(LoginEntity user) {
    _user = user;
  }

  void setApplications(CurrentUserApplicationEntity apps) {
    _applications = apps;
  }

  void setHoliday(List<HolidayEntity> holiday) {
    _holidayEntity = holiday;
  }

  void setLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
  }

  void clearAll() {
    _user = null;
    _applications = null;
    _holidayEntity = null;
    _isLoggedIn = false;
  }
}
