import 'package:flutter/foundation.dart';

class LoginInfoProvider extends ChangeNotifier {
  String sessionId = '';
  String accountId = '';
  String username = '';

  void signIn(String sessionId, String accountId, String username) {
    this.sessionId = sessionId;
    this.accountId = accountId;
    this.username = username;
    notifyListeners();
  }

  void signOut(){
    sessionId='';
    accountId='';
    username='';
    notifyListeners();
  }

  bool get isSignedIn {
    return sessionId.isNotEmpty ? true : false;
  }
}
