import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/inventory_view_model.dart';
import 'package:provider/provider.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<InventoryViewModel>(context, listen: false).addItem(
                  nameController.text,
                  int.tryParse(quantityController.text) ?? 0,
                );
                Navigator.pop(context);
              },
              child: const Text('Add Item'),
            )
          ],
        ),
      ),
    );
  }
}
