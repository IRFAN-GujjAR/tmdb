import 'package:flutter/foundation.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/utils/shared_pref/shared_pref_utils.dart';

class LoginInfoProvider extends ChangeNotifier {
  UserInfoModel _userInfo;
  UserInfoModel get user => _userInfo;

  String get sessionId => isSignedIn ? _userInfo.sessionId : '';
  int get accountId => isSignedIn ? _userInfo.userId : 0;
  String get username => isSignedIn ? _userInfo.userName : '';

  LoginInfoProvider({@required UserInfoModel userInfo}) : _userInfo = userInfo;

  void signIn(UserInfoModel userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  Future<void> signOut() async {
    await SharedPrefUtils.deleteLoginDetails();
    _userInfo = null;
    notifyListeners();
  }

  bool get isSignedIn => _userInfo != null;
}
