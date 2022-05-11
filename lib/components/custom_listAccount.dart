// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names, camel_case_types

class customListAccount extends StatelessWidget {
  final String title_name;
  final String iconLeft;
  final String iconRight;

  const customListAccount(
      {Key? key,
      required this.title_name,
      required this.iconLeft,
      required this.iconRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        leading: Image.asset(iconLeft),
        title: Text(title_name),
        trailing: Image.asset(iconRight),
      ),
    );
  }
}
