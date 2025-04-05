import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/ui/screen_utils.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  TextSpan _clickableText(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: ColorUtils.accentColor(context),
        decoration: TextDecoration.underline,
      ),
      recognizer:
          TapGestureRecognizer()
            ..onTap = () async {
              final url = Uri.parse('https://' + text);
              try {
                await launchUrl(url);
              } catch (e) {
                logger.e(e);
              }
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: CustomBodyWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: PagePadding.leftPadding,
            right: PagePadding.rightPadding,
            top: PagePadding.topPadding,
            bottom: PagePadding.bottomPadding,
          ),
          child: SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '📱 TMDb App:\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
                TextSpan(
                  text:
                      'This app is built using The Movie Database (TMDb) API and brings you detailed '
                      'information about your favorite movies, TV shows, and trending content — '
                      'all in one place.\nThe app uses beautiful illustrations from Storyset, '
                      'adding a friendly touch to your browsing experience.\n\n',
                ),
                TextSpan(
                  text: '🔗 Open Source:\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
                TextSpan(
                  text:
                      'This app is open source! Check out the code or contribute on GitHub: ',
                ),
                _clickableText(context, 'github.com/IRFAN-GujjAR/tmdb'),
                TextSpan(
                  text: '\n\n📌 Credits:\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
                TextSpan(text: '- Data powered by '),
                _clickableText(context, 'themoviedb.org'),
                TextSpan(text: '\n- Illustrations by Storyset: '),
                _clickableText(context, 'storyset.com'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
