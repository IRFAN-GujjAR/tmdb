import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/models/user_info_model.dart';

class SharedPrefUtils {
  static const String _SESSION_ID = 'sessionId';
  static const String _USER_ID = 'userId';
  static const String _USER_NAME = 'username';
  static const String _IS_APP_STARTED_FIRST_TIME = 'app_started_first_time';

  static bool isAppStartedForFirstTime(SharedPreferences pref) {
    final isAppStartedFirstTime = pref.getBool(_IS_APP_STARTED_FIRST_TIME);
    return isAppStartedFirstTime == null || isAppStartedFirstTime;
  }

  static bool isUserDetailsEmpty(SharedPreferences pref) {
    final sessionId = pref.getString(_SESSION_ID);
    final userId = pref.getInt(_USER_ID);
    final userName = pref.getString(_USER_NAME);
    return (sessionId == null || sessionId.isEmpty) ||
        (userId == null || userId == 0) ||
        (userName == null || userName.isEmpty);
  }

  static Future<UserInfoModel> loadUserDetails(SharedPreferences pref) async {
    final sessionId = pref.getString(_SESSION_ID);
    final userId = pref.getInt(_USER_ID);
    final userName = pref.getString(_USER_NAME);
    return UserInfoModel(
        userId: userId, userName: userName, sessionId: sessionId);
  }

  static Future<void> saveUserDetails(
      SharedPreferences pref, UserInfoModel userInfo) async {
    await pref.setInt(_USER_ID, userInfo.userId);
    await pref.setString(_USER_NAME, userInfo.userName);
    await pref.setString(_SESSION_ID, userInfo.sessionId);
    await pref.setBool(_IS_APP_STARTED_FIRST_TIME, false);
  }

  static Future<void> deleteLoginDetails() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_SESSION_ID, '');
    await pref.setInt(_USER_ID, 0);
    await pref.setString(_USER_NAME, '');
  }
}
