import 'package:flutter/material.dart';
import 'package:shoppablecard/components/social_button.dart';

class SocialSignin extends StatelessWidget {
  const SocialSignin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: const [
          SocialButton(
              image: 'assets/images/facebook.png',
              text: 'Sign In With Facebook'),
          SizedBox(
            height: 20.0,
          ),
          SocialButton(
              image: 'assets/images/google.png', text: 'Sign In With Google'),
        ],
      ),
    );
  }
}

mixin SvgPicture {}
