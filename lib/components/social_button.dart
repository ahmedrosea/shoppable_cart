import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.image, required this.text})
      : super(key: key);
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18.0),
      minWidth: double.infinity,
      onPressed: () {},
      child: Row(children: [
        Image.asset(image),
        const SizedBox(
          width: 50.0,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'SFPro',
          ),
          textAlign: TextAlign.center,
        )
      ]),
      shape: Border.all(
        color: const Color(0xFFDDDDDD),
      ),
    );
  }
}
