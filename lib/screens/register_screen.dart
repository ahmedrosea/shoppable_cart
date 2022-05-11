import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/default_text_form_field.dart';
import 'package:shoppablecard/screens/home_screen.dart';
import 'package:shoppablecard/services/register_service.dart';
import 'package:email_validator/email_validator.dart';
import '../components/default_button.dart';
import '../default_colors.dart';
import '../state_management/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: _loading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: Color(0xFF000000),
                              size: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 30.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Color(0xff000000),
                                      fontFamily: 'SFPro',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                  DefaultTextFormField(
                                    labelText: 'Name',
                                    errorText: 'The Name field can\'t be empty',
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  DefaultTextFormField(
                                    labelText: 'Email',
                                    errorText:
                                        'The Email field can\'t be empty',
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
                                    height: 50.0,
                                  ),
                                  DefaultButton(
                                      text: 'Sign Up',
                                      onPressed: () {
                                        setState(() {
                                          if (formKey.currentState!
                                              .validate()) {
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
                                            } else {
                                              _loading = true;
                                              RegisterService()
                                                  .Register(
                                                      fullName:
                                                          nameController.text,
                                                      emailAddress:
                                                          emailController.text,
                                                      password:
                                                          passwordController
                                                              .text)
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
                                                              fontFamily:
                                                                  'SFPro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          content: const Text(
                                                            'Invalid Email or Password or user is already exists',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'SFPro',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
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
                                                                  style:
                                                                      TextStyle(
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
                                      })
                                ]),
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }
}
