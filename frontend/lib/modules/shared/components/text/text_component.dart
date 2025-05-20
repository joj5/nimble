import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/shared/resources/fonts.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TextComponent extends StatelessWidget {
  String text;
  var fontSize = textSizeLargeMedium;
  Color? textColor;
  var fontFamily;
  bool isCentered = false;
  var maxLine = 1;
  var latterSpacing = 0.5;
  bool textAllCaps = false;
  bool isLongText = false;
  bool lineThrough = false;

  TextComponent(
    this.text, {
    super.key,
    var fontSize = textSizeLargeMedium,
    Color? textColor,
    var fontFamily,
    bool isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    bool isLongText = false,
    bool lineThrough = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor ??
            secondaryAppTextColor, // frontendStore.textSecondaryColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
