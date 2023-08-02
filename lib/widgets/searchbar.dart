import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
