import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;

  const CustomSearchBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SearchBar(
        controller: controller,
        hintText: "Search",
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const SearchBar({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }
}
