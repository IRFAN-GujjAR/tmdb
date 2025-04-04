import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';

import '../../../entities/common/credits/cast_entity.dart';
import '../../utils.dart';
import '../text_row_widget.dart';
import 'details_divider_widget.dart';

class DetailsCastAndCrewItemsWidget extends StatelessWidget {
  final CreditsEntity credits;
  final String previousPageTitle;

  const DetailsCastAndCrewItemsWidget({
    super.key,
    required this.credits,
    required this.previousPageTitle,
  });

  Widget get _divider {
    return DetailsDividerWidget(topPadding: 15.0);
  }

  @override
  Widget build(BuildContext context) {
    List<CastEntity> cast = credits.cast;
    int length = 0;

    if (cast.length <= 15) {
      length = cast.length;
    } else {
      length = 15;
    }

    return Column(
      children: <Widget>[
        _divider,
        TextRowWidget(
          categoryName: 'Cast & Crew',
          showSeeAllBtn: true,
          onPressed: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.SEE_ALL_CAST_CREW,
              extra: credits,
            );
          },
        ),
        Container(
          height: 130,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  appRouterConfig.push(
                    context,
                    location: AppRouterPaths.CELEBRITY_DETAILS,
                    extra: CelebrityDetailsPageExtra(
                      id: cast[index].id,
                      celebName: cast[index].name,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomNetworkImageWidget(
                        type: MediaImageType.Celebrity,
                        imageUrl:
                            cast[index].profilePath != null
                                ? URLS.profileImageUrl(
                                  imageUrl: cast[index].profilePath!,
                                  size: ProfileSizes.w185,
                                )
                                : null,
                        width: 85,
                        height: 85,
                        fit: BoxFit.fitWidth,
                        borderRadius: 50,
                        placeHolderSize: 50,
                        celebrityPlaceHolderCircularShape: true,
                      ),
                      // Container(
                      //   width: 85,
                      //   height: 85,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey, width: 1),
                      //     borderRadius: BorderRadius.circular(50),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child:
                      //         cast[index].profilePath == null
                      //             ? CelebrityProfilePlaceholderWidget(size: 50)
                      //             : Image.network(
                      //               URLS.profileImageUrl(
                      //                 imageUrl: cast[index].profilePath!,
                      //                 size: ProfileSizes.w185,
                      //               ),
                      //               fit: BoxFit.fitWidth,
                      //             ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          cast[index].name,
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                          cast[index].character,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: length,
          ),
        ),
      ],
    );
  }
}
