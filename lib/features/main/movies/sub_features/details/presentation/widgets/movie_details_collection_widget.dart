part of '../pages/movie_details_page.dart';

final class MovieDetailsCollectionWidget extends StatelessWidget {
  final CollectionEntity collection;
  final List<GenreEntity> genres;
  final String? posterPath;
  final String? backdropPath;

  const MovieDetailsCollectionWidget({
    super.key,
    required this.collection,
    required this.genres,
    required this.posterPath,
    required this.backdropPath,
  });

  @override
  Widget build(BuildContext context) {
    String genresText = '';

    if (genres.isNotEmpty) {
      for (int i = 0; i < genres.length; i++) {
        genresText.isEmpty
            ? genresText = genres[i].name
            : genresText = genresText + ', ' + genres[i].name;
      }
    }

    String? imageUrl = collection.posterPath ?? posterPath;
    if (imageUrl != null) {
      imageUrl = URLS.posterImageUrl(
        imageUrl: imageUrl,
        size: PosterSizes.w185,
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DetailsDividerWidget(topPadding: 15),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 15),
          child: Text(
            'Collection',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        GestureDetector(
          onTap: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.MOVIE_COLLECTION_DETAILS_LOCATION,
              extra: MovieCollectionDetailsPageExtra(
                id: collection.id,
                name: collection.name,
                posterPath: posterPath,
                backdropPath: backdropPath,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: CustomNetworkImageWidget(
                    type: MediaImageType.Movie,
                    imageUrl: imageUrl,
                    width: 80,
                    height: 100,
                    fit: BoxFit.fitWidth,
                    borderRadius: 0,
                    placeHolderSize: 60,
                  ),
                ),
                Container(
                  width: 240,
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        collection.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14),
                      ),
                      genresText.isNotEmpty
                          ? Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              genresText,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : Container(),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(CupertinoIcons.forward, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
