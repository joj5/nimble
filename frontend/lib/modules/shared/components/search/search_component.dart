import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/nimble/ui/search/screens/search_screen.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

class SearchComponent extends StatefulWidget {
  const SearchComponent({super.key});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          right: 16.0,
          left: 16.0,
        ),
        decoration: boxDecoration(
          backgroundColor: viewAppColor.withOpacity(0.8),
        ),
        child: TextField(
          autofocus: false,
          readOnly: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
