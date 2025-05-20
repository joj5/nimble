import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/inventory_view_model.dart';
import 'package:frontend/views/add_item_view.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InventoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: ListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (context, index) {
          final item = viewModel.items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Quantity: ${item.onHand}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => viewModel.deleteItem(item.serialNumber),
            ),
            onTap: () => showDialog(
              context: context,
              builder: (_) {
                final controller =
                    TextEditingController(text: item.onHand.toString());
                return AlertDialog(
                  title: Text('Update ${item.name}'),
                  content: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        viewModel.updateQuantity(
                            item.serialNumber, int.parse(controller.text));
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddItemView()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
