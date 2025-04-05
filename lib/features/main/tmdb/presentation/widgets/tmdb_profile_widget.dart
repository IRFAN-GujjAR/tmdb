import 'package:flutter/material.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/photo/extra/celebrity_photo_page_extra.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';

class TMDbProfileWidget extends StatelessWidget {
  final AccountDetailsEntity? accountDetails;

  const TMDbProfileWidget({super.key, required this.accountDetails});

  Widget _profileImageWidget(BuildContext context) {
    return accountDetails?.profilePath != null
        ? GestureDetector(
          onTap: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.CELEBRITY_PHOTO,
              extra: CelebrityPhotoPageExtra(
                name: accountDetails!.username,
                photo: accountDetails!.profilePath!,
              ),
            );
          },
          child: CustomNetworkImageWidget(
            type: MediaImageType.Celebrity,
            imageUrl: URLS.profileImageUrl(
              imageUrl: accountDetails!.profilePath!,
              size: ProfileSizes.w45,
            ),
            width: 45,
            height: 45,
            fit: BoxFit.fitWidth,
            borderRadius: 45,
            placeHolderSize: 45,
          ),
        )
        : const Icon(Icons.account_circle, size: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 14),
        _profileImageWidget(context),
        SizedBox(width: 10),
        Text(
          accountDetails?.username ?? 'Your Name',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
        ),
      ],
    );
  }
}
