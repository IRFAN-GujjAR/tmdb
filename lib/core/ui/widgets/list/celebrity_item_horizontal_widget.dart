import 'package:flutter/material.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_item_params.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';

class CelebrityItemHorizontalWidget extends StatelessWidget {
  final CelebrityItemParams _params;

  const CelebrityItemHorizontalWidget(this._params, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appRouterConfig.push(
          context,
          location: AppRouterPaths.CELEBRITY_DETAILS,
          extra: CelebrityDetailsPageExtra(
            id: _params.id,
            celebName: _params.name,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        width: _params.config.listItemWidth,
        child: Column(
          children: <Widget>[
            CustomNetworkImageWidget(
              type: MediaImageType.Celebrity,
              imageUrl:
                  _params.profilePath != null
                      ? URLS.profileImageUrl(
                        imageUrl: _params.profilePath!,
                        size: ProfileSizes.w185,
                      )
                      : null,
              width: _params.config.listItemWidth,
              height: _params.config.imageHeight,
              fit: BoxFit.fitWidth,
              borderRadius: 10,
              placeHolderSize: 72,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _params.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: _params.config.font,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            if (_params.knownFor != null)
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _params.knownFor!,
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
  }
}
