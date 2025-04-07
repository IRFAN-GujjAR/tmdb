import 'package:flutter/material.dart';
import '../../domain/entities/user_session_entity.dart';
import '../../domain/repositories/user_session_repo.dart';
import '../../domain/use_cases/user_session_load_use_case.dart';

final class UserSessionProvider extends ChangeNotifier {
  late UserSessionLoadUseCase _loadUseCase;

  UserSessionProvider(UserSessionRepo repo) {
    _loadUseCase = UserSessionLoadUseCase(repo);
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

  Future<void> get reset async {
    _userSession = UserSessionEntity.empty();
    notifyListeners();
  }
}
