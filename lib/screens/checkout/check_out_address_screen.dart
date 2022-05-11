import 'package:flutter/material.dart';
import 'package:shoppablecard/components/default_text_form_field.dart';
import 'package:shoppablecard/screens/checkout/check_out_screen.dart';

class CheckoutAddressScreen extends StatelessWidget {
  const CheckoutAddressScreen({Key? key}) : super(key: key);
  static TextEditingController street1Controller = TextEditingController();
  static TextEditingController street2Controller = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController stateController = TextEditingController();
  static TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: SingleChildScrollView(
        child: Form(
          key: CheckoutScreen.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Note: Billing address is the same as delivery address',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                  fontFamily: 'SFPro',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                labelText: 'Street 1',
                errorText: 'Street 1 can\'t be empty.',
                keyboardType: TextInputType.streetAddress,
                controller: street1Controller,
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                labelText: 'Street 2',
                errorText: 'Street 2 can\'t be empty.',
                keyboardType: TextInputType.streetAddress,
                controller: street2Controller,
              ),
              const SizedBox(
                height: 20.0,
              ),
              DefaultTextFormField(
                labelText: 'City',
                errorText: 'City can\'t be empty.',
                keyboardType: TextInputType.text,
                controller: cityController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextFormField(
                      labelText: 'State',
                      errorText: 'State can\'t be empty.',
                      keyboardType: TextInputType.text,
                      controller: stateController,
                    ),
                  ),
                  const SizedBox(
                    width: 40.0,
                  ),
                  Expanded(
                    child: DefaultTextFormField(
                      labelText: 'Country',
                      errorText: 'Country can\'t be empty.',
                      keyboardType: TextInputType.text,
                      controller: countryController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
