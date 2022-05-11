import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/default_button.dart';
import 'package:shoppablecard/components/default_text_form_field.dart';
import 'package:shoppablecard/components/social_sign_in.dart';
import 'package:shoppablecard/screens/home_screen.dart';
import 'package:shoppablecard/screens/register_screen.dart';
import 'package:shoppablecard/services/login_service.dart';

import '../default_colors.dart';
import '../state_management/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: const [
                                        Text(
                                          'Welcome',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'SFPro',
                                          ),
                                        ),
                                        Text(
                                          'Sign in to Continue',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color(0xff929292),
                                            fontFamily: 'SFPro',
                                            height: 2.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: DefaultColors.defaultBlueColor,
                                          fontFamily: 'SFPro',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                DefaultTextFormField(
                                  labelText: 'Email',
                                  errorText: 'The Email field can\'t be empty',
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                DefaultTextFormField(
                                  labelText: 'Password',
                                  errorText:
                                      'The Password field can\'t be empty',
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  isPassword: true,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFF707070),
                                      fontFamily: 'SFPro',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                DefaultButton(
                                  text: 'Sign In',
                                  onPressed: () {
                                    setState(() {
                                      if (formKey.currentState!.validate()) {
                                        if (EmailValidator.validate(
                                                emailController.text) ==
                                            false) {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Invalid Email',
                                                    style: TextStyle(
                                                      fontFamily: 'SFPro',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Example: example@example.com',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily: 'SFPro',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'OK',
                                                          style: TextStyle(
                                                            color: DefaultColors
                                                                .defaultBlueColor,
                                                            fontFamily: 'SFPro',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ))
                                                  ],
                                                );
                                              });
                                        } else {
                                          _loading = true;
                                          LoginService()
                                              .login(
                                                  emailAddress:
                                                      emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((success) {
                                            context
                                                .read<MyProvider>()
                                                .setUserData();
                                            if (success) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreen()));
                                            } else {
                                              setState(() {
                                                _loading = false;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                        'Invalid',
                                                        style: TextStyle(
                                                          fontFamily: 'SFPro',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        'Invalid Email or Password',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontFamily: 'SFPro',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                color: DefaultColors
                                                                    .defaultBlueColor,
                                                                fontFamily:
                                                                    'SFPro',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ))
                                                      ],
                                                    );
                                                  });
                                            }

                                            ///
                                          });
                                        }
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          '-OR-',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'SFPro',
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const SocialSignin(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
