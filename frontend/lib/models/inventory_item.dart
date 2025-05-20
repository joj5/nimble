class InventoryItem {
  int onHand;

  final String name;
  final String serialNumber;

  InventoryItem({
    required this.name,
    required this.serialNumber,
    required this.onHand,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      name: json['name'].toString(),
      serialNumber: json['serialNumber'].toString(),
      onHand: json['onHand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'serialNumber': serialNumber,
      'onHand': onHand,
    };
  }
}
