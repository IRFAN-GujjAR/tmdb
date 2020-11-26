import 'package:flutter/material.dart';

class ScrollControllerUtil {
  final _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  void addScrollListener(Function onScroll) {
    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        onScroll();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
  }
}
