import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'logo.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Logo(),
        // SearchBar(),
      ],
    );
  }
}
