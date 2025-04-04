import 'package:flutter/material.dart';

import '../../assets/illustrations.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No results',
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(AssetIllustrations.searchResultsNotFound(context)),
        ],
      ),
    );
  }
}
