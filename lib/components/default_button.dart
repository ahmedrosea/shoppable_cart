import 'package:flutter/material.dart';

import '../default_colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, this.onPressed, required this.text})
      : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: DefaultColors.defaultBlueColor,
      padding: const EdgeInsets.all(16.0),
      minWidth: double.infinity,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontFamily: 'SFPro',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
