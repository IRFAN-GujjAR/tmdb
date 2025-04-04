import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';

class CustomListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final GestureTapCallback onPressed;

  const CustomListTileWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorUtils.scaffoldBackgroundColor(context),
      child: MaterialButton(
        onPressed: onPressed,
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(
              icon,
              size: 28,
              color: ColorUtils.primaryColor(context),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(color: ColorUtils.primaryColor(context)),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleSmall!.color,
            ),
          ),
        ),
      ),
    );
  }
}
