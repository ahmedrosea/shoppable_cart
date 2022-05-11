import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.grey[100],
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
          size: 32.0,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(44.0)),
        ),
      ),
    );
  }
}
