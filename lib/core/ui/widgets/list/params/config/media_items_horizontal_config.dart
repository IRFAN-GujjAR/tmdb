import '../../../../utils.dart';

final class MediaItemsHorizontalConfig {
  final double listViewHeight;
  final double listItemWidth;
  final double imageHeight;
  final double font;
  final PosterSizes posterSize;
  final BackdropSizes backdropSize;

  MediaItemsHorizontalConfig({
    required this.listViewHeight,
    required this.listItemWidth,
    required this.imageHeight,
    required this.font,
    required this.posterSize,
    required this.backdropSize,
  });

  factory MediaItemsHorizontalConfig.fromDefault() =>
      MediaItemsHorizontalConfig(
        listViewHeight: 205.0,
        listItemWidth: 99.0,
        imageHeight: 139.0,
        font: 12,
        posterSize: PosterSizes.w185,
        backdropSize: BackdropSizes.w300,
      );
}
