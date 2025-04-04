import 'package:flutter/material.dart';

import '../../../../../core/entities/celebs/celebrity_entity.dart';
import '../../../../../core/router/routes/app_router_paths.dart';
import '../../../../../core/ui/initialize_app.dart';
import '../../../../../core/ui/screen_utils.dart';
import '../../../../../core/ui/utils.dart';
import '../../../../../core/ui/widgets/custom_image_widget.dart';
import '../../../../../core/urls/urls.dart';
import '../../sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';

class CelebritiesPopularWidget extends StatelessWidget {
  final List<CelebrityEntity> firstHalfPopular;
  final List<CelebrityEntity> secondHalfPopular;

  const CelebritiesPopularWidget({
    super.key,
    required this.firstHalfPopular,
    required this.secondHalfPopular,
  });

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

  Widget _popularCelebs(List<CelebrityEntity> celebs) {
    final double listViewHeight = 200;
    final double imageHeight = 130;
    final double listItemWidth = 100;

    return Container(
      height: listViewHeight,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: celebs.length,
        padding: EdgeInsets.only(
          left: PagePadding.leftPadding,
          right: PagePadding.rightPadding,
        ),
        separatorBuilder: (BuildContext context, int index) {
          return Container(width: 32);
        },
        itemBuilder: (BuildContext context, int index) {
          String? imageUrl = celebs[index].profilePath;
          if (imageUrl != null) {
            imageUrl = URLS.profileImageUrl(
              imageUrl: imageUrl,
              size: ProfileSizes.w185,
            );
          }

          return GestureDetector(
            onTap: () {
              _navigateToCelebritiesDetails(context, celebs[index]);
            },
            child: Container(
              width: listItemWidth,
              child: Column(
                children: <Widget>[
                  CustomNetworkImageWidget(
                    type: MediaImageType.Celebrity,
                    imageUrl: imageUrl,
                    width: listItemWidth,
                    height: imageHeight,
                    fit: BoxFit.fitWidth,
                    borderRadius: 10,
                    placeHolderSize: 85,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        celebs[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  if (celebs[index].knownFor != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          celebs[index].knownFor!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _marginSpacer {
    return SizedBox(height: 8);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _popularCelebs(firstHalfPopular),
        const SizedBox(height: 8),
        _popularCelebs(secondHalfPopular),
      ],
    );
  }
}
