import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/widgets/custom_icon_button_widget.dart';

class ShareMenuButtonWidget extends StatelessWidget {
  final Uri url;

  const ShareMenuButtonWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CustomIconButtonWidget(
      onPressed: () async {
        try {
          await Share.shareUri(url);
        } catch (e) {
          logger.e(e);
        }
      },
      icon: Icons.share,
      enable: true,
    );
  }
}
