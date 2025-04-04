import 'package:tmdb/core/ui/utils.dart';

final class CelebrityItemConfig {
  final double listViewHeight;
  final double listItemWidth;
  final double imageHeight;
  final double font;
  final ProfileSizes profileSize;

  CelebrityItemConfig({
    required this.listViewHeight,
    required this.listItemWidth,
    required this.imageHeight,
    required this.font,
    required this.profileSize,
  });

  factory CelebrityItemConfig.fromDefault() => CelebrityItemConfig(
    listViewHeight: 205.0,
    listItemWidth: 99.0,
    imageHeight: 139.0,
    font: 12,
    profileSize: ProfileSizes.w185,
  );
}
