import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_bar_provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  Widget _buildSearchField(BuildContext context, SearchBarProvider provider) {
    return TextField(
      controller: provider.searchController,
      focusNode: provider.focusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        border: InputBorder.none,
      ),
      onChanged: (query) {
        provider.onChanged(context, query);
      },
      onSubmitted: (query) {
        provider.onSubmit(context, query);
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, SearchBarProvider provider) {
    if (provider.showSearch) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            provider.closeSearch(context);
          },
        ),
      ];
    }
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          provider.setShowSearch = true;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchBarProvider>(
      builder: (context, provider, child) {
        return AppBar(
          leading:
              provider.showSearch
                  ? BackButton(
                    onPressed: () {
                      provider.closeSearch(context);
                    },
                  )
                  : null,
          title:
              provider.showSearch
                  ? _buildSearchField(context, provider)
                  : Text('Search'),
          actions: _buildActions(context, provider),
        );
      },
    );
  }
}
