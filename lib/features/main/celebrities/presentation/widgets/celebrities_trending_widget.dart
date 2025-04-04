import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/entities/celebs/celebrity_entity.dart';
import '../../../../../core/router/routes/app_router_paths.dart';
import '../../../../../core/ui/initialize_app.dart';
import '../../../../../core/ui/utils.dart';
import '../../../../../core/ui/widgets/custom_image_widget.dart';
import '../../../../../core/urls/urls.dart';
import '../../sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';

class CelebritiesTrendingWidget extends StatelessWidget {
  final List<CelebrityEntity> celebs;

  const CelebritiesTrendingWidget({super.key, required this.celebs});

  Widget get _marginSpacer {
    return SizedBox(height: 8);
  }

  void _navigateToCelebritiesDetails(
    BuildContext context,
    CelebrityEntity celeb,
  ) {
    appRouterConfig.push(
      context,
      location: AppRouterPaths.CELEBRITY_DETAILS,
      extra: CelebrityDetailsPageExtra(id: celeb.id, celebName: celeb.name),
    );
  }

  Widget _buildTrendingCelebsItems(
    BuildContext context,
    CelebrityEntity celeb,
  ) {
    String? imageUrl = celeb.profilePath;
    if (imageUrl != null) {
      imageUrl = URLS.profileImageUrl(
        imageUrl: imageUrl,
        size: ProfileSizes.w185,
      );
    }
    return GestureDetector(
      onTap: () {
        _navigateToCelebritiesDetails(context, celeb);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(width: 0, style: BorderStyle.none),
        ),
        child: Row(
          children: <Widget>[
            CustomNetworkImageWidget(
              type: MediaImageType.Celebrity,
              imageUrl: imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.fitWidth,
              borderRadius: 35,
              placeHolderSize: 45,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    celeb.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                if (celeb.knownFor != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 2),
                    child: Text(
                      celeb.knownFor!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            Spacer(),
            Icon(CupertinoIcons.forward, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _getTopRatedItems(
    BuildContext context,
    int mainIndex,
    int itemIndex,
    List<CelebrityEntity>? firstPairCelebs,
    List<CelebrityEntity>? secondPairCelebs,
    List<CelebrityEntity>? thirdPairCelebs,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTrendingCelebsItems(context, firstPairCelebs![itemIndex]);
      case 1:
        return _buildTrendingCelebsItems(context, secondPairCelebs![itemIndex]);
      default:
        return _buildTrendingCelebsItems(context, thirdPairCelebs![itemIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CelebrityEntity>? firstPairCelebs;
    List<CelebrityEntity>? secondPairCelebs;
    List<CelebrityEntity>? thirdPairCelebs;

    for (int i = 0; i < 12; i++) {
      if (i >= 0 && i <= 3) {
        if (firstPairCelebs == null) {
          firstPairCelebs = [celebs[i]];
        } else {
          firstPairCelebs.add(celebs[i]);
        }
      } else if (i >= 4 && i <= 7) {
        if (secondPairCelebs == null) {
          secondPairCelebs = [celebs[i]];
        } else {
          secondPairCelebs.add(celebs[i]);
        }
      } else if (i >= 8 && i <= 11) {
        if (thirdPairCelebs == null) {
          thirdPairCelebs = [celebs[i]];
        } else {
          thirdPairCelebs.add(celebs[i]);
        }
      }
    }

    return Container(
      height: 350,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int mainIndex) {
          return Container(
            margin: const EdgeInsets.only(left: 12),
            width: 310,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTopRatedItems(
                  context,
                  mainIndex,
                  0,
                  firstPairCelebs,
                  secondPairCelebs,
                  thirdPairCelebs,
                ),
                _marginSpacer,
                _getTopRatedItems(
                  context,
                  mainIndex,
                  1,
                  firstPairCelebs,
                  secondPairCelebs,
                  thirdPairCelebs,
                ),
                _marginSpacer,
                _getTopRatedItems(
                  context,
                  mainIndex,
                  2,
                  firstPairCelebs,
                  secondPairCelebs,
                  thirdPairCelebs,
                ),
                _marginSpacer,
                _getTopRatedItems(
                  context,
                  mainIndex,
                  3,
                  firstPairCelebs,
                  secondPairCelebs,
                  thirdPairCelebs,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(width: 8);
        },
        itemCount: 3,
      ),
    );
  }
}
