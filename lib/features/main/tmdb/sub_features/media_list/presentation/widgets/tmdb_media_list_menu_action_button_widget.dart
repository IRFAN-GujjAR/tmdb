import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/sort_by_cf_category.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_provider.dart';

import '../../../../../../../core/ui/theme/colors/colors_utils.dart';

class TMDbMediaListMenuActionButtonWidget extends StatelessWidget {
  const TMDbMediaListMenuActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TMDbMediaListProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<SortByCFCategory>(
          icon: Icon(Icons.sort),
          color: ColorUtils.appBarColor(context),
          onSelected: (value) {
            provider.setSortBy(context, value);
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<SortByCFCategory>(
                value: SortByCFCategory.desc,
                child: RadioListTile<SortByCFCategory>(
                  value: SortByCFCategory.desc,
                  groupValue: provider.sortBy,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                  title: Text(
                    'Newest',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              PopupMenuItem<SortByCFCategory>(
                value: SortByCFCategory.asc,
                child: RadioListTile<SortByCFCategory>(
                  value: SortByCFCategory.asc,
                  groupValue: provider.sortBy,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                  title: Text(
                    'Oldest',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ];
          },
        );
      },
    );
  }
}
