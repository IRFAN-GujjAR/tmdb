// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tmdb/core/theme/theme_utils.dart';
// import 'package:tmdb/features/app_startup/data/tables/user_info_model.dart';
// import 'package:tmdb/features/app_startup/domain/entities/user_info_entity.dart';
//
// class SharedPrefUtils {
//   static const String _USER_ID = 'userId';
//   static const String _USER_NAME = 'username';
//   static const String _IS_APP_STARTED_FIRST_TIME = 'app_started_first_time';
//   static const String _APP_THEME = 'app_theme';
//
//   static bool isAppStartedForFirstTime(SharedPreferences pref) {
//     final isAppStartedFirstTime = pref.getBool(_IS_APP_STARTED_FIRST_TIME);
//     return isAppStartedFirstTime == null || isAppStartedFirstTime;
//   }
//
//   static bool isUserDetailsEmpty(SharedPreferences pref) {
//     final sessionId = pref.getString(_SESSION_ID);
//     final userId = pref.getInt(_USER_ID);
//     final userName = pref.getString(_USER_NAME);
//     return (sessionId == null || sessionId.isEmpty) ||
//         (userId == null || userId == 0) ||
//         (userName == null || userName.isEmpty);
//   }
//
//   static Future<UserInfoEntity> loadUserDetails(SharedPreferences pref) async {
//     final sessionId = pref.getString(_SESSION_ID)!;
//     final userId = pref.getInt(_USER_ID)!;
//     final userName = pref.getString(_USER_NAME)!;
//     return UserInfoEntity(
//         userId: userId, userName: userName, sessionId: sessionId);
//   }
//
//   static AppThemes appTheme(SharedPreferences pref) {
//     final index = pref.getInt(_APP_THEME) ?? 0;
//     return AppThemes.values[index];
//   }
//
//   static Future<void> setAppTheme(
//       SharedPreferences pref, AppThemes appTheme) async {
//     await pref.setInt(_APP_THEME, appTheme.index);
//   }
//
//   static Future<void> saveUserDetails(
//       SharedPreferences pref, UserInfoModel userInfo) async {
//     await pref.setInt(_USER_ID, userInfo.userId);
//     await pref.setString(_USER_NAME, userInfo.userName);
//     await pref.setString(_SESSION_ID, userInfo.sessionId);
//     await pref.setBool(_IS_APP_STARTED_FIRST_TIME, false);
//   }
//
//   static Future<void> deleteLoginDetails(SharedPreferences pref) async {
//     await pref.setString(_SESSION_ID, '');
//     await pref.setInt(_USER_ID, 0);
//     await pref.setString(_USER_NAME, '');
//   }
// }
