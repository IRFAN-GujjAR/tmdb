import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_session_model.dart';

abstract class UserSessionDataSource {
  Future<UserSessionModel> get load;
  Future<void> store(UserSessionModel userSession);
  Future<void> get delete;
}

final class UserSessionDataSourceImpl implements UserSessionDataSource {
  final String _userId = 'user_id';
  final String _sessionId = 'session_id';
  final AndroidOptions _androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final _iOSOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  FlutterSecureStorage get _storage =>
      FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iOSOptions);

  @override
  Future<UserSessionModel> get load async {
    final result = await _storage.readAll();
    if (result.isEmpty) {
      return UserSessionModel.empty();
    } else {
      final userId = int.parse(result[_userId]!);
      final sessionId = result[_sessionId]!;
      return UserSessionModel(userId: userId, sessionId: sessionId);
    }
  }

  @override
  Future<void> store(UserSessionModel userSession) async {
    await _storage.write(key: _userId, value: userSession.userId.toString());
    await _storage.write(key: _sessionId, value: userSession.sessionId);
  }

  @override
  Future<void> get delete async {
    await _storage.deleteAll();
  }
}
