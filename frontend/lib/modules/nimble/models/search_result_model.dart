class SearchResultModel {
  String? name;

  String? imageOne;
  String? imageTwo;
  String? status;
  String? medicineOne;
  String? medicineTwo;

  SearchResultModel(
      {this.name,
      this.imageOne,
      this.imageTwo,
      this.status,
      this.medicineOne,
      this.medicineTwo});
}

class SearchModel {
  String? value;

  SearchModel({
    this.value,
  });
}

List<SearchModel> searchQueryList = [
  SearchModel(
    value: 'Robotic',
  ),
  SearchModel(
    value: 'Eco Campus',
  ),
  SearchModel(
    value: 'Live discussion',
  ),
];

class SDFilterModel {
  String? value;
  bool isSelected = false;

  SDFilterModel({
    this.value,
  });
}

List<SDFilterModel> mFilterList = [
  SDFilterModel(
    value: 'Robotic',
  ),
  SDFilterModel(
    value: 'Eco Campus',
  ),
  SDFilterModel(
    value: 'Live discussion',
  ),
];
