import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';

class BottomNavigationProvider extends ChangeNotifier {
  var _navigationKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  List<GlobalKey<NavigatorState>> get navigationKeys => _navigationKeys;

  List<int> _indexesStack = [0];
  int _index = 0;

  List<int> get indexesStack => _indexesStack;
  int get index => _index;

  void navigate({@required int index, @required dynamic page}) {
    _navigationKeys[index]
        .currentState
        .push(MaterialPageRoute(builder: (context) => page));
  }

  Future<bool> mayPop(int index) async {
    return await _navigationKeys[index].currentState.maybePop();
  }

  void _isSameTabPressed(int index) {
    if (_navigationKeys[index].currentState != null && _index == index) {
      _navigationKeys[_index].currentState.popUntil((route) => route.isFirst);
    }
  }

  void _setTabIndex(int index) {
    _isSameTabPressed(index);
    _index = index;
    notifyListeners();
  }

  void selectTab(int index) {
    if (!isIOS) {
      if (_index != index) {
        _indexesStack.add(index);
      }
    }
    _setTabIndex(index);
  }

  Future<bool> onPopBack() async {
    final isFirstRouteInCurrentTab = !await mayPop(index);
    if (isFirstRouteInCurrentTab) {
      {
        if (index != 0) {
          _indexesStack.removeLast();
          _setTabIndex(_indexesStack.last);
          return false;
        }
      }
    }
    return isFirstRouteInCurrentTab;
  }

  void reset() {
    _indexesStack = [0];
    _index = 0;
    _navigationKeys = List.generate(_navigationKeys.length, (i) {
      return GlobalKey<NavigatorState>();
    });
  }
}
