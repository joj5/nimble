import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/shared/resources/fonts.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('images/grey.jpg', fit: BoxFit.cover);

// Widget commonCachedNetworkImage(
//   String? url, {
//   double? height,
//   double? width,
//   BoxFit? fit,
//   AlignmentGeometry? alignment,
//   bool usePlaceholderIfUrlEmpty = true,
//   double? radius,
//   Color? color,
// }) {
//   if (url!.isEmpty) {
//     return placeHolderWidget(
//         height: height,
//         width: width,
//         fit: fit,
//         alignment: alignment,
//         radius: radius);
//   } else if (url.startsWith('http')) {
//     return CachedNetworkImage(
//       imageUrl: url,
//       height: height,
//       width: width,
//       fit: fit,
//       color: color,
//       alignment: alignment as Alignment? ?? Alignment.center,
//       errorWidget: (_, s, d) {
//         return placeHolderWidget(
//             height: height,
//             width: width,
//             fit: fit,
//             alignment: alignment,
//             radius: radius);
//       },
//       placeholder: (_, s) {
//         if (!usePlaceholderIfUrlEmpty) return SizedBox();
//         return placeHolderWidget(
//             height: height,
//             width: width,
//             fit: fit,
//             alignment: alignment,
//             radius: radius);
//       },
//     );
//   } else {
//     return Image.asset(url,
//             height: height,
//             width: width,
//             fit: fit,
//             alignment: alignment ?? Alignment.center)
//         .cornerRadiusWithClipRRect(radius ?? defaultRadius);
//   }
// }

Widget textField(
    {String? title, IconData? image, TextInputType? textInputType}) {
  return TextField(
    keyboardType: textInputType,
    style: primaryTextStyle(),
    decoration: InputDecoration(
      hintText: title,
      hintStyle: secondaryTextStyle(size: 16),
      fillColor: Colors.grey,
      suffixIcon: Icon(image, color: Colors.grey, size: 20),
    ),
  );
}
