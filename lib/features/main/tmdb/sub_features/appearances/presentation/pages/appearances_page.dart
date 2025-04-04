import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/providers/theme_provider.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';

import '../../../../../../../core/ui/screen_utils.dart';

class AppearancesPage extends StatelessWidget {
  const AppearancesPage({super.key});

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: PagePadding.topPadding,
        bottom: PagePadding.bottomPadding,
      ),
      child: Consumer<ThemeProvider>(
        builder:
            (context, provider, _) => Column(
              children: [
                RadioListTile<AppThemes>(
                  title: Text(
                    appThemeName[AppThemes.DeviceTheme]!,
                    style: TextStyle(
                      color:
                          provider.appTheme == AppThemes.DeviceTheme
                              ? ColorUtils.accentColor(context)
                              : Colors.grey,
                    ),
                  ),
                  value: AppThemes.DeviceTheme,
                  groupValue: provider.appTheme,
                  onChanged: (value) {
                    if (value != null)
                      provider.setTheme(context, appTheme: value);
                  },
                ),
                DividerWidget(),
                RadioListTile<AppThemes>(
                  title: Text(
                    appThemeName[AppThemes.LightTheme]!,
                    style: TextStyle(
                      color:
                          provider.appTheme == AppThemes.LightTheme
                              ? ColorUtils.accentColor(context)
                              : Colors.grey,
                    ),
                  ),
                  value: AppThemes.LightTheme,
                  groupValue: provider.appTheme,
                  onChanged: (value) {
                    if (value != null)
                      provider.setTheme(context, appTheme: value);
                  },
                ),
                DividerWidget(),
                RadioListTile<AppThemes>(
                  title: Text(
                    appThemeName[AppThemes.DarkTheme]!,
                    style: TextStyle(
                      color:
                          provider.appTheme == AppThemes.DarkTheme
                              ? ColorUtils.accentColor(context)
                              : Colors.grey,
                    ),
                  ),
                  value: AppThemes.DarkTheme,
                  groupValue: provider.appTheme,
                  onChanged: (value) {
                    if (value != null)
                      provider.setTheme(context, appTheme: value);
                  },
                ),
              ],
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appearances')),
      body: CustomBodyWidget(child: _buildBody(context)),
    );
  }
}
