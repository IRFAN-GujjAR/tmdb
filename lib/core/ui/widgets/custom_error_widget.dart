import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_types.dart';

import '../../assets/illustrations.dart';

class CustomErrorWidget extends StatelessWidget {
  final CustomErrorEntity error;
  final VoidCallback onPressed;

  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onPressed,
  });

  Widget _errorImage(BuildContext context) {
    String assetImage = '';
    switch (error.type) {
      case CustomErrorTypes.NetworkError:
        assetImage = AssetIllustrations.networkError(context);
        break;
      case CustomErrorTypes.UnknownError:
        assetImage = AssetIllustrations.unknownError(context);
        break;
      case CustomErrorTypes.ServerError:
        assetImage = AssetIllustrations.serverError(context);
        break;
    }
    return Image.asset(assetImage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _errorImage(context),
            SizedBox(height: 20),
            Text(
              error.error.errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: onPressed, child: const Text('RETRY')),
          ],
        ),
      ),
    );
  }
}
