import 'package:flutter/material.dart';

import '../../domain/entities/user_session_entity.dart';
import '../../domain/repositories/user_session_repo.dart';
import '../../domain/use_cases/user_session_delete_use_case.dart';
import '../../domain/use_cases/user_session_load_use_case.dart';
import '../../domain/use_cases/user_session_store_use_case.dart';

final class UserSessionProvider extends ChangeNotifier {
  late UserSessionLoadUseCase _loadUseCase;
  late UserSessionStoreUseCase _storeUseCase;
  late UserSessionDeleteUseCase _deleteUseCase;

  UserSessionProvider(UserSessionRepo repo) {
    _loadUseCase = UserSessionLoadUseCase(repo);
    _storeUseCase = UserSessionStoreUseCase(repo);
    _deleteUseCase = UserSessionDeleteUseCase(repo);
  }

  UserSessionEntity _userSession = UserSessionEntity.empty();
  UserSessionEntity get userSession => _userSession;
  set setUserSession(UserSessionEntity value) {
    _userSession = value;
    notifyListeners();
  }

  bool get isLoggedIn => !userSession.isEmpty;

  Future<void> get loadWithoutNotify async {
    final userSession = await _loadUseCase.call;
    _userSession = userSession;
  }

  Future<void> get load async {
    final userSession = await _loadUseCase.call;
    _userSession = userSession;
    notifyListeners();
  }

  Future<void> store(UserSessionEntity userSession) async {
    await _storeUseCase.call(userSession);
    _userSession = userSession;
    notifyListeners();
  }

  Future<void> get delete async {
    await _deleteUseCase.call;
    _userSession = UserSessionEntity.empty();
    notifyListeners();
  }
}
