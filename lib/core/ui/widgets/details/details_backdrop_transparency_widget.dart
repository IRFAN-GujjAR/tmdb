import 'package:flutter/material.dart';
import '../../theme/colors/colors_utils.dart';

class DetailsBackdropTransparencyWidget extends StatelessWidget {
  const DetailsBackdropTransparencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 150),
      child: Container(
        width: double.infinity,
        height: 76,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              ColorUtils.scaffoldBackgroundColor(context),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.9],
          ),
        ),
      ),
    );
  }
}
