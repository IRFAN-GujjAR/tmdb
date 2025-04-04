class PagePadding {
  static const double topPadding = 24.0;
  static const double leftPadding = 12.0;
  static const double rightPadding = 12.0;
  static const double bottomPadding = 48.0;

  // static double bottomPadding(BuildContext context,
  //         {bool includeBottomNavHeight = true, double? bottom}) =>
  //     isIOS
  //         ? includeBottomNavHeight
  //             ? (padding(context).bottom + (bottom ?? 40))
  //             : (bottom ?? 40)
  //         : bottom ?? 40;
  // static double topPadding(BuildContext context,
  //         {bool includeTopPadding = true,
  //         bool includeTextBarHeight = false,
  //         double? top}) =>
  //     isIOS
  //         ? includeTopPadding
  //             ? (padding(context).top +
  //                 (includeTextBarHeight ? kTextTabBarHeight : 0) +
  //                 (top ?? 0))
  //             : (top ?? 10)
  //         : top ?? 0;

  // static double get homePageTopPadding => 10;
  // static double homePageBottomPadding(BuildContext context) =>
  //     isIOS ? padding(context).bottom + 40 : 40;

  // static EdgeInsets padding(BuildContext context) =>
  //     MediaQuery.of(context).padding;

  // static double get topPaddingListWithTabs => 20;
  // static double topPaddingListWithoutTabs(BuildContext context,
  //         {bool includeTopPadding = true,
  //         bool includeTextbarHeight = false,
  //         double? top}) =>
  //     topPadding(context,
  //         top: top ?? 20,
  //         includeTopPadding: includeTopPadding,
  //         includeTextBarHeight: includeTextbarHeight);
}
