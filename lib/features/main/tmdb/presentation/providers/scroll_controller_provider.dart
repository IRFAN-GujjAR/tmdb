import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb/core/ui/scroll_controller_util.dart';

abstract class ScrollControllerProvider extends ChangeNotifier {
  final _parentScrollController = ScrollController();
  ScrollController get parentScrollController => _parentScrollController;
  final _scrollControllerUtil1 = ScrollControllerUtil();
  ScrollControllerUtil get scrollControllerUtil1 => _scrollControllerUtil1;
  ScrollController get scrollController1 =>
      _scrollControllerUtil1.scrollController;
  final _scrollControllerUtil2 = ScrollControllerUtil();
  ScrollControllerUtil get scrollControllerUtil2 => _scrollControllerUtil2;
  ScrollController get scrollController2 =>
      _scrollControllerUtil2.scrollController;

  ScrollControllerProvider() {
    scrollController1.addListener(() {
      _addListener(scrollController1);
    });
    scrollController2.addListener(() {
      _addListener(scrollController2);
    });
  }

  @override
  void dispose() {
    _parentScrollController.dispose();
    _scrollControllerUtil1.dispose();
    _scrollControllerUtil2.dispose();
    super.dispose();
  }

  void _addListener(ScrollController scrollController) {
    var innerPos = scrollController.position.pixels;
    var currentOutPos = parentScrollController.position.pixels;
    var currentParentPos = innerPos + currentOutPos;

    if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward ||
        innerPos == 0) {
      parentScrollController.position.animateTo(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      _scrollTo(currentParentPos);
    }
  }

  bool onScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.pixels == 0) _scrollTo(0);
    return true;
  }

  void _scrollTo(double position) {
    _parentScrollController.position.animateTo(
      position,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}
