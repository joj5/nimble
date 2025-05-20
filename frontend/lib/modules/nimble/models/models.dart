import 'package:flutter/material.dart';

class QuizBadgesModel {
  var title = "";
  var subtitle = "";
  var img = "";
}

class QuizScoresModel {
  var title = "";
  var totalQuiz = "";
  var img = "";
  var scores = "";
}

class QuizContactUsModel {
  var title = "";
  var subtitle = "";
}

class CategoryModel {
  String? image;
  String? title;
  String? backgroundImages;

  CategoryModel({
    this.image,
    this.title,
    this.backgroundImages,
  });
}

class CompleteItemDetailsModel {
  String? title;
  String? data;

  CompleteItemDetailsModel({this.title, this.data});
}

class OPPickVerifyModel {
  String? image;
  String? cardTitle;
  String? cardSubTitle;
  Color? cardColor;
  String? cardExpireDate;
  String? cardNumber;
  IconData? icon;
  Widget? newScreen;

  OPPickVerifyModel(
      {this.image,
      this.cardTitle,
      this.cardSubTitle,
      this.cardColor,
      this.cardExpireDate,
      this.cardNumber,
      this.icon,
      this.newScreen});
}

class ShPaymentCard {
  var cardNo = "3434 3434 3434";
  var month = "01";
  var year = "2021";
  var cvv = "123";
  var holderName = "John";
}
