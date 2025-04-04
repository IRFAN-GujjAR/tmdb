import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tmdb/core/ui/initialize_app.dart';

import '../theme/colors/colors_utils.dart';

class SharePopMenuButtonWidget extends StatelessWidget {
  final Uri url;

  const SharePopMenuButtonWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: ColorUtils.appBarColor(context),
      onSelected: (value) async {
        if (value == 1) {
          try {
            await Share.shareUri(url);
          } catch (e) {
            logger.e(e);
          }
        }
      },
      itemBuilder:
          (BuildContext context) => [
            PopupMenuItem(value: 1, child: Text('Share')),
          ],
    );
  }
}
