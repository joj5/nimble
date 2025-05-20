import 'package:frontend/modules/nimble/resources/images.dart';

class WalkThroughModel {
  String? img;
  String? title;
  String? backgroundImg;

  WalkThroughModel({this.img, this.title, this.backgroundImg});
}

List walkThroughModels = [
  WalkThroughModel(
      img: walk1, title: 'Inventory Reports', backgroundImg: bgWalk),
  WalkThroughModel(img: walk2, title: 'Cost Estimates', backgroundImg: bgWalk),
  WalkThroughModel(
      img: walk3, title: 'Real Time Tracking', backgroundImg: bgWalk),
  WalkThroughModel(
      img: walk4, title: 'Inventory Notifications', backgroundImg: bgWalk),
  WalkThroughModel(img: walk5, title: 'Secured Data', backgroundImg: bgWalk),
];
