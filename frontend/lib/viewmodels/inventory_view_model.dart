import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/resources/strings.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/inventory_item.dart';
import 'package:uuid/uuid.dart';

class InventoryViewModel extends ChangeNotifier {
  List<InventoryItem> _items = [];

  List<InventoryItem> get items => _items;

  InventoryViewModel() {
    fetchItems();
  }

  Future<void> fetchItems() async {
    final response = await http.get(Uri.parse(inventoryURL));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      _items = jsonData.map((e) => InventoryItem.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load inventory items');
    }
  }

  void addItem(String name, int onHand) async {
    final newItem = InventoryItem(
        name: name, serialNumber: const Uuid().v4(), onHand: onHand);

    final response = await http.post(
      Uri.parse(inventoryURL),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newItem.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      fetchItems();
    } else {
      throw Exception('Failed to add item');
    }
  }

  void updateQuantity(String serialNumber, int newQuantity) async {
    final item = _items.firstWhere(
        (inventoryItem) => inventoryItem.serialNumber == serialNumber);
    item.onHand = newQuantity;

    final response = await http.put(
      Uri.parse('$inventoryURL/$serialNumber'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode == 200) {
      fetchItems();
    } else {
      throw Exception('Failed to update item');
    }
  }

  void deleteItem(String serialNumber) async {
    final response =
        await http.delete(Uri.parse('$inventoryURL/$serialNumber'));

    if (response.statusCode == 200 || response.statusCode == 204) {
      _items.removeWhere(
          (inventoryItem) => inventoryItem.serialNumber == serialNumber);
      notifyListeners();
    } else {
      throw Exception('Failed to delete item');
    }
  }
}
