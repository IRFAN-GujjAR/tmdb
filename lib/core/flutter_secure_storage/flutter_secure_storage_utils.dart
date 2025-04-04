import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';

final class FlutterSecureStorageUtils {
  final String _appStartedForFirst = 'app_started_for_first_time';
  final String _userId = 'user_id';
  final String _username = 'username';
  final String _sessionId = 'session_id';

  final AndroidOptions _androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final _iOSOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  late FlutterSecureStorage _storage;
  FlutterSecureStorage get storage => _storage;

  bool _isAppStartedForFirstTime = true;
  bool get isAppStartedForFirstTime => _isAppStartedForFirstTime;

  SecureStorageUtils() {
    _storage =
        FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iOSOptions);
  }

  Future<void> saveUserInfo(UserSessionEntity userInfo) async {
    await storage.write(key: _appStartedForFirst, value: false.toString());
    await storage.write(key: _userId, value: userInfo.userId.toString());
    await storage.write(key: _username, value: userInfo.username);
    await storage.write(key: _sessionId, value: userInfo.sessionId);
  }

  Future<void> setAppStartedForFirstTime(bool value) async {
    await storage.write(key: _appStartedForFirst, value: value.toString());
  }

  Future<UserSessionEntity?> get getUserInfo async {
    final values = await storage.readAll();
    if (values.isEmpty) {
      return null;
    }
    final startCount = values[_appStartedForFirst];
    if (startCount != null) {
      _isAppStartedForFirstTime = false;
    }
    if (values.length < 2) {
      return null;
    }
    return UserSessionEntity(
        userId: int.parse(values[_userId]!),
        username: values[_username]!,
        sessionId: values[_sessionId]!);
  }
}
