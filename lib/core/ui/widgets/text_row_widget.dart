import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/screen_utils.dart';

class TextRowWidget extends StatelessWidget {
  final String categoryName;
  final bool showSeeAllBtn;
  final VoidCallback? onPressed;

  const TextRowWidget({
    super.key,
    required this.categoryName,
    required this.showSeeAllBtn,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: PagePadding.leftPadding),
      child: Row(
        children: <Widget>[
          Text(
            categoryName,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          showSeeAllBtn
              ? CupertinoButton(
                onPressed: onPressed,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        'See all',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Icon(CupertinoIcons.forward, color: Colors.grey, size: 14),
                  ],
                ),
              )
              : Padding(padding: const EdgeInsets.only(top: 30, bottom: 20)),
        ],
      ),
    );
  }
}
