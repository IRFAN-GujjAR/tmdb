import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_events.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

class SearchWidget extends StatelessWidget {
  final String query;
  final ValueChanged<String> onSubmit;

  const SearchWidget({@required this.query, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiSearchBloc, MultiSearchState>(
        builder: (context, multiSearchState) {
      if (multiSearchState is MultiSearchLoaded) {
        final searches = multiSearchState.searches;

        int length = 0;
        length = searches.length;
        if (length < 18) {
          length = 18;
        }

        return Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: isIOS
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onSubmit(searches[index]);
                      },
                      child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 0)),
                          margin: const EdgeInsets.only(left: 10),
                          child: index < searches.length
                              ? Text(searches[index])
                              : SizedBox(
                                  height: 10,
                                )),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.3,
                      height: 20,
                      indent: 10,
                      color: Colors.grey,
                    );
                  },
                  itemCount: length)
              : ListView.builder(
                  itemCount: searches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          onSubmit(searches[index]);
                        },
                        leading: Icon(Icons.search),
                        title: Text(searches[index]));
                  }),
        );
      } else if (multiSearchState is MultiSearchLoadingError) {
        return InternetConnectionErrorWidget(onPressed: () {
          context.read<MultiSearchBloc>().add(SearchMultiSearch(query: query));
        });
      }

      return LoadingWidget();
    });
  }
}
