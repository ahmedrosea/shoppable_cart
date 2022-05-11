import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../default_colors.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField(
      {Key? key,
      required this.labelText,
      this.controller,
      this.errorText,
      this.keyboardType,
      this.isPassword = false,
      this.type,
      this.onChanged})
      : super(key: key);
  final String labelText;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? type;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 18.0,
        fontFamily: 'SFPro',
      ),
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        errorStyle: const TextStyle(
          fontFamily: 'SFPro',
        ),
        labelStyle: const TextStyle(
          color: Color(0x80000000),
          fontFamily: 'SFPro',
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.defaultBlueColor,
          ),
        ),
      ),
      maxLength: type == 'Creditcard' ? 19 : null,
      inputFormatters: type == 'Creditcard'
          ? [
              CreditCardFormatter(),
            ]
          : (type == 'expiryDate'
              ? [CreditCardExpirationDateFormatter()]
              : (type == 'cvv' ? [CreditCardCvcInputFormatter()] : null)),
      validator: (text) {
        if (text!.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
