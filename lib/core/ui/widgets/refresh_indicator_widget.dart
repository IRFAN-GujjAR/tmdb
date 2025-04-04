import 'dart:async';

import 'package:flutter/material.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  final void Function(Completer<void> completer) onRefresh;
  final Widget child;
  const RefreshIndicatorWidget({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  Future<void> _onRefresh(BuildContext context) async {
    final completer = Completer<void>();
    onRefresh(completer);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: child, onRefresh: () => _onRefresh(context));
  }
}
