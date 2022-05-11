import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/default_text_form_field.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/screens/checkout/check_out_screen.dart';
import 'package:shoppablecard/state_management/provider.dart';

class PaymentsCreditcardScreen extends StatefulWidget {
  const PaymentsCreditcardScreen({Key? key}) : super(key: key);
  static TextEditingController cardNumberController = TextEditingController();
  static TextEditingController expiryDateController = TextEditingController();
  static TextEditingController cvvController = TextEditingController();
  static TextEditingController nameController = TextEditingController();

  @override
  State<PaymentsCreditcardScreen> createState() =>
      _PaymentsCreditcardScreenState();
}

class _PaymentsCreditcardScreenState extends State<PaymentsCreditcardScreen> {
  String text = '';
  bool isChecked = false;

  @override
  void initState() {
    PaymentsCreditcardScreen.cardNumberController.text =
        context.read<MyProvider>().cardNumber;
    PaymentsCreditcardScreen.expiryDateController.text =
        context.read<MyProvider>().expiryDate;
    PaymentsCreditcardScreen.nameController.text =
        context.read<MyProvider>().cardName;
    PaymentsCreditcardScreen.cvvController.text =
        context.read<MyProvider>().cvv;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: CheckoutScreen.formKey,
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultTextFormField(
                labelText: 'Name on Card',
                errorText: 'Name can\'t be empty',
                keyboardType: TextInputType.name,
                controller: PaymentsCreditcardScreen.nameController,
                onChanged: (newText) {
                  context.read<MyProvider>().setCardSystem(cardName: newText);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              DefaultTextFormField(
                labelText: 'Card Number',
                errorText: 'Card Number can\'t be empty',
                keyboardType: TextInputType.number,
                controller: PaymentsCreditcardScreen.cardNumberController,
                type: 'Creditcard',
                onChanged: (newText) {
                  context
                      .read<MyProvider>()
                      .setCardNumber(numberOfCard: newText);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextFormField(
                      labelText: 'Expiry Date',
                      errorText: 'Expiry Date can\'t be empty',
                      keyboardType: TextInputType.number,
                      type: 'expiryDate',
                      controller: PaymentsCreditcardScreen.expiryDateController,
                      onChanged: (newText) {
                        context
                            .read<MyProvider>()
                            .setCardSystem(expiryDate: newText);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 40.0,
                  ),
                  Expanded(
                    child: DefaultTextFormField(
                      labelText: 'CVV',
                      errorText: 'CVV can\'t be empty',
                      keyboardType: TextInputType.number,
                      type: 'cvv',
                      controller: PaymentsCreditcardScreen.cvvController,
                      onChanged: (newText) {
                        context.read<MyProvider>().setCardSystem(cvv: newText);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.6,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green;
                        }
                        return DefaultColors.defaultBlueColor;
                      }),
                      value: isChecked,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'Save this card details',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontFamily: 'SFPro',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
