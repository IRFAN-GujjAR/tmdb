import 'package:flutter/material.dart';
import 'package:tmdb/core/assets/illustrations.dart';

class NoItemsFoundWidget extends StatelessWidget {
  const NoItemsFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetIllustrations.searchResultsNotFound(context)),
            SizedBox(height: 20),
            Text(
              'No results found!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
