import 'package:flutter/material.dart';
import '../screens/base_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.search_rounded,
      size: 64,
      color: Colors.deepPurple,
    );
  }
}
