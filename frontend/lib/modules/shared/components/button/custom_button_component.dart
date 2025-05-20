import 'package:flutter/material.dart';

class CustomButtonComponent extends StatefulWidget {
  double? minWidth;
  double? height;
  Widget? child;
  TextStyle? textStyle;
  ShapeBorder? shapeBorder;
  double? elevation;
  VoidCallback? onPressed;
  Color? color;
  Color? hoverColor;
  Color? splashColor;
  Color? focusColor;

  CustomButtonComponent(
      {super.key,
      this.minWidth,
      this.height,
      this.child,
      this.textStyle,
      this.shapeBorder,
      this.elevation,
      this.onPressed,
      this.color,
      this.hoverColor,
      this.splashColor,
      this.focusColor});

  @override
  State<CustomButtonComponent> createState() => _CustomButtonComponentState();
}

class _CustomButtonComponentState extends State<CustomButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: widget.minWidth,
      height: widget.height,
      shape: widget.shapeBorder,
      elevation: widget.elevation,
      onPressed: widget.onPressed,
      color: widget.color,
      hoverColor: widget.hoverColor,
      splashColor: widget.splashColor,
      focusColor: widget.focusColor,
      child: widget.child,
    );
  }
}
