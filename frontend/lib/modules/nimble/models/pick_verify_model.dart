import 'package:flutter/material.dart';

class PickVerifyModel {
  String? image;
  String? cardTitle;
  String? cardSubTitle;
  Color? cardColor;
  String? cardExpireDate;
  String? cardNumber;
  IconData? icon;
  Widget? newScreen;

  PickVerifyModel({
    this.image,
    this.cardTitle,
    this.cardSubTitle,
    this.cardColor,
    this.cardExpireDate,
    this.cardNumber,
    this.icon,
    this.newScreen,
  });
}
