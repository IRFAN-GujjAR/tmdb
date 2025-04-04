import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';

class CustomRatingWidget extends StatelessWidget {
  final double voteAverage;
  final int voteCount;
  final double? iconSize;
  final double? fontSize;
  final EdgeInsets? voteCountPading;
  final EdgeInsets? margin;

  const CustomRatingWidget({
    Key? key,
    required this.voteAverage,
    required this.voteCount,
    this.iconSize,
    this.fontSize,
    this.voteCountPading,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<IconData>? stars;

    double rating = voteAverage / 2;
    int counter = rating.toInt();

    for (int i = 0; i < counter; i++) {
      stars == null ? stars = [Icons.star] : stars.add(Icons.star);
    }

    if (rating.toString().contains('.')) {
      if (voteCount == 0 && voteAverage == 0) {
        stars = [Icons.star_border];
      } else {
        stars == null ? stars = [Icons.star_half] : stars.add(Icons.star_half);
      }
    }
    while (stars!.length < 5) {
      stars.add(Icons.star_border);
    }

    return Container(
      margin: margin ?? const EdgeInsets.only(top: 2, left: 4),
      height: 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return index != 5
              ? Icon(stars![index], size: iconSize ?? 15)
              : Padding(
                padding:
                    voteCountPading ?? const EdgeInsets.only(left: 5, top: 2),
                child: Text(
                  '( $voteCount )',
                  style: TextStyle(
                    fontSize: fontSize ?? 11,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.primaryColor(context),
                  ),
                ),
              );
        },
        itemCount: 6,
      ),
    );
  }
}
