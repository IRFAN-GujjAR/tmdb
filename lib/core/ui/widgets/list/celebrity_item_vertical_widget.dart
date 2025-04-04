import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_item_vertical_params.dart';
import 'package:tmdb/core/urls/urls.dart';

import '../../../../features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';
import '../../../router/routes/app_router_paths.dart';
import '../../initialize_app.dart';
import '../../utils.dart';
import '../custom_image_widget.dart';

class CelebrityItemVerticalWidget extends StatelessWidget {
  final CelebrityItemVerticalParams _params;

  const CelebrityItemVerticalWidget(this._params, {super.key});

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
        decoration: BoxDecoration(
          border: Border.all(width: 0, style: BorderStyle.none),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              width: 70,
              height: 105,
              fit: BoxFit.fitHeight,
              borderRadius: 0,
              placeHolderSize: 65,
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      _params.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (_params.knownFor != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Text(
                        _params.knownFor!,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, right: 10),
              child: Icon(CupertinoIcons.forward, color: Colors.grey, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
