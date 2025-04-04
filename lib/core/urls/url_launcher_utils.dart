import 'package:tmdb/main.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> launchYoutube(String url) async {
    url = (isIOS ? 'youtube' : 'https') + '://www.youtube.com/watch?v=' + url;
    try {
      final urlUri = Uri.parse(url);
      await launchUrl(urlUri);
    } catch (error) {
      print(error);
    }
  }
}
