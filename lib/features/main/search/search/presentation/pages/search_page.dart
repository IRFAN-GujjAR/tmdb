import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/features/main/search/details/presentation/pages/search_details_page.dart';
import 'package:tmdb/features/main/search/search/presentation/providers/search_bar_provider.dart';
import 'package:tmdb/features/main/search/search/presentation/widgets/search_bar_widget.dart';
import 'package:tmdb/features/main/search/search/presentation/widgets/search_suggestions_widget.dart';
import 'package:tmdb/features/main/search/trending_search/presentation/widgets/trending_search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const SearchBarWidget(),
      ),
      body: GestureDetector(
        onTap: () {
          hideKeyBoard(context);
        },
        child: CustomBodyWidget(
          child: Consumer<SearchBarProvider>(
            builder: (context, provider, _) {
              switch (provider.searchPageType) {
                case SearchPageType.Trending:
                  return const TrendingSearchWidget();
                case SearchPageType.Suggestions:
                  return provider.query.isEmpty
                      ? Center(
                        child: Text(
                          'Search for movies,tv shows, celebrities',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      )
                      : SearchSuggestionsWidget();
                case SearchPageType.Details:
                  return SearchDetailsPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
