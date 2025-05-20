import 'package:frontend/modules/nimble/models/search_result_model.dart';
import 'package:frontend/modules/nimble/resources/images.dart';

List<SearchResultModel> loadSearchResults(String searchQuery) {
  List<SearchResultModel> products = [
    SearchResultModel(
        name: 'Cheese',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Cheapest',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Cheese',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Cheapest',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Cheese',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Expensive',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Bacon',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Cheapest',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Ham',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Expensive',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Corn',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Cheapest',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
    SearchResultModel(
        name: 'Bread',
        imageOne: promotionPlaceholder,
        imageTwo: promotionPlaceholder,
        status: 'Expensive',
        medicineOne: 'frontendle Cinder Vinegar Goli',
        medicineTwo: 'High Potency Vitamin'),
  ];

  List<SearchResultModel> filteredResults = [];

  for (var product in products) {
    if (product.name!.toLowerCase().contains(searchQuery.toLowerCase())) {
      filteredResults.add(product);
    }
  }

  return filteredResults;
}
