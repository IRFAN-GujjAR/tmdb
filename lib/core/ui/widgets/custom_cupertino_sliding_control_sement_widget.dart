// import 'package:flutter/cupertino.dart';
//
// class CustomCupertinoSlidingControlSegmentWidget<T> extends StatelessWidget {
//   final T groupValue;
//   final Map<T, Widget> children;
//   final Function(T?) onValueChanged;
//
//   const CustomCupertinoSlidingControlSegmentWidget(
//       {Key? key,
//       required this.groupValue,
//       required this.children,
//       required this.onValueChanged})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: CupertinoTheme.of(context).barBackgroundColor,
//         padding: const EdgeInsets.only(top: 8, bottom: 8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CupertinoSlidingSegmentedControl<T>(
//                 thumbColor: CupertinoTheme.of(context).primaryColor,
//                 groupValue: groupValue,
//                 children: children,
//                 onValueChanged: onValueChanged),
//           ],
//         ));
//   }
// }
