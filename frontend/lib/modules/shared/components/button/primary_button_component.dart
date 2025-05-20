import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class PrimaryButtonComponent extends StatefulWidget {
  String textContent;
  VoidCallback onPressed;
  var isStroked = false;
  var height = 40.0;

  PrimaryButtonComponent({
    super.key,
    required this.textContent,
    required this.onPressed,
    this.isStroked = false,
    this.height = 45.0,
  });

  @override
  State<PrimaryButtonComponent> createState() => _PrimaryButtonComponentState();
}

class _PrimaryButtonComponentState extends State<PrimaryButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: const EdgeInsets.fromLTRB(
          16,
          4,
          16,
          4,
        ),
        alignment: Alignment.center,
        decoration: widget.isStroked
            ? boxDecoration(
                backgroundColor: Colors.transparent,
                color: Colors.grey,
              )
            : boxDecoration(
                backgroundColor: primaryBrandColor,
                radius: 6,
              ),
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          style: boldTextStyle(
            size: 16,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
