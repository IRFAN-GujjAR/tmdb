import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_filled_button_widget.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_state.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/providers/rate_provider.dart';

import '../../../../../../../core/ui/utils.dart';
import '../../../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../../../core/ui/widgets/movie_poster_placeholder_widget.dart';
import '../../../../../../../core/ui/widgets/tv_poster_placeholder_widget.dart';
import '../../../../../../../core/urls/urls.dart';
import '../blocs/rate_media_bloc.dart';

class RatePage extends StatelessWidget {
  const RatePage({super.key});

  void rate(BuildContext context) {
    context.read<RateProvider>().rate(context);
  }

  void deleteRating(BuildContext context) async {
    context.read<RateProvider>().deleteRating(context);
  }

  Widget _buildRatingWidget(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Consumer<RateProvider>(
            builder: (context, provider, child) {
              return GestureDetector(
                onTap: () {
                  provider.setRating = index + 1;
                },
                child: Icon(
                  provider.rating <= index ? Icons.star_border : Icons.star,
                  size: 28,
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 4);
        },
        itemCount: 10,
      ),
    );
  }

  Widget _buildRatingBody(BuildContext context) {
    final extra = context.read<RateProvider>().extra;
    var topPadding = 40;

    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child:
              extra.posterPath == null
                  ? extra.mediaType.isMovie
                      ? MoviePosterPlaceHolderWidget(size: 96)
                      : TvPosterPlaceholderWidget(size: 96)
                  : CachedNetworkImage(
                    imageUrl: URLS.posterImageUrl(
                      imageUrl: extra.posterPath!,
                      size: PosterSizes.w342,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.8)),
          ),
        ),
        BlocConsumer<RateMediaBloc, RateMediaState>(
          listener: (context, state) {
            context.read<RateProvider>().handleState(context, state);
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: topPadding + 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 225,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child:
                        extra.posterPath == null
                            ? extra.mediaType.isMovie
                                ? MoviePosterPlaceHolderWidget(size: 72)
                                : TvPosterPlaceholderWidget(size: 72)
                            : CachedNetworkImage(
                              imageUrl: URLS.posterImageUrl(
                                imageUrl: extra.posterPath!,
                                size: PosterSizes.w342,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Consumer<RateProvider>(
                      builder: (context, provider, child) {
                        return Text(
                          provider.rating.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                  _buildRatingWidget(context),
                  SizedBox(height: 15),
                  Consumer<RateProvider>(
                    builder: (context, provider, child) {
                      return CustomFilledButtonWidget(
                        enable: provider.enable(state),
                        onPressed: () {
                          rate(context);
                        },
                        child: Text('Rate'),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  extra.isRated
                      ? Consumer<RateProvider>(
                        builder: (context, provider, child) {
                          return CustomFilledButtonWidget(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            enable: provider.enable(state),
                            onPressed: () {
                              deleteRating(context);
                            },
                            child: Text('Delete Rating'),
                          );
                        },
                      )
                      : Container(),
                ],
              ),
            );
          },
        ),
        Consumer<RateProvider>(
          builder: (context, provider, child) {
            if (provider.showLoadingIndicator) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(color: Colors.grey.withOpacity(0.1)),
                  LoadingWidget(),
                ],
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: CustomBodyWidget(child: _buildRatingBody(context)),
    );
  }
}
