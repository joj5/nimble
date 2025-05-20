import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textFieldType;
  final FocusNode? focus;
  VoidCallback? editingComplete;

  TextFieldComponent({
    super.key,
    this.editingComplete,
    required this.controller,
    required this.hintText,
    required this.textFieldType,
    required this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: editingComplete,
      controller: controller,
      keyboardType: textFieldType,
      style: primaryTextStyle(size: 14),
      focusNode: focus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 8,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: primaryTextStyle(size: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
/*
  void _newFocusNode() {
    final newFocus = _emailFocusNode ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
  */
}
