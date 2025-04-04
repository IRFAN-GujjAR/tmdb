import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/no_items_found_widget.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';
import 'package:tmdb/features/main/search/search/presentation/blocs/search_bloc.dart';
import 'package:tmdb/features/main/search/search/presentation/providers/search_bar_provider.dart';

import '../../../../../../core/ui/widgets/loading_widget.dart';

class SearchSuggestionsWidget extends StatelessWidget {
  const SearchSuggestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        switch (state) {
          case SearchStateInitial():
          case SearchStateLoading():
            return LoadingWidget();
          case SearchStateLoaded():
            final searches = state.searchesEntity.searches;

            int length = 0;
            length = searches.length;
            if (length < 18) {
              length = 18;
            }

            final padding = const EdgeInsets.only(
              top: PagePadding.topPadding,
              bottom: PagePadding.bottomPadding,
            );

            return ListView.builder(
              padding: padding,
              itemCount: searches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.read<SearchBarProvider>().onSuggestItemPressed(
                      context,
                      searches[index].searchTitle,
                    );
                  },
                  leading: Icon(Icons.search, color: Colors.grey),
                  title: Text(searches[index].searchTitle),
                );
              },
            );
          case SearchStateNoItemsFound():
            return const NoItemsFoundWidget();
          case SearchStateError():
            return CustomErrorWidget(
              error: state.error,
              onPressed: () {
                context.read<SearchBloc>().add(
                  SearchEventLoad(
                    params: SearchParams(
                      query: context.read<SearchBarProvider>().query,
                      pageNo: 1,
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
