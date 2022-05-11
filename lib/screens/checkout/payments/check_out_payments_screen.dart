import 'package:flutter/material.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/screens/checkout/payments/payments_cod_screen.dart';
import 'package:shoppablecard/screens/checkout/payments/payments_credit_card_screen.dart';

class CheckoutPaymentsScreen extends StatefulWidget {
  const CheckoutPaymentsScreen({Key? key}) : super(key: key);

  static String currentScreen = 'creditCard';

  @override
  State<CheckoutPaymentsScreen> createState() => _CheckoutPaymentsScreenState();
}

class _CheckoutPaymentsScreenState extends State<CheckoutPaymentsScreen> {
  late Color codButtonColor;
  late Color creditCardButtonColor;
  late Color creditCardIconColor;
  late Color codIconColor;
  late Color creditCardButtonBorderColor;
  late Color codButtonBorderColor;

  @override
  void initState() {
    if (CheckoutPaymentsScreen.currentScreen == 'creditCard') {
      codButtonColor = Colors.transparent;
      creditCardButtonColor = DefaultColors.defaultBlueColor;
      creditCardIconColor = Colors.white;
      codIconColor = const Color(0xFFBEBEBE);
      creditCardButtonBorderColor = DefaultColors.defaultBlueColor;
      codButtonBorderColor = const Color(0xFFDDDDDD);
    } else {
      codButtonColor = DefaultColors.defaultBlueColor;
      creditCardButtonColor = Colors.transparent;
      creditCardIconColor = const Color(0xFFBEBEBE);
      codIconColor = Colors.white;
      creditCardButtonBorderColor = const Color(0xFFDDDDDD);
      codButtonBorderColor = DefaultColors.defaultBlueColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(children: [
        SizedBox(
          height: 80.0,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      CheckoutPaymentsScreen.currentScreen = 'creditCard';
                      creditCardButtonColor = DefaultColors.defaultBlueColor;
                      codButtonColor = Colors.transparent;
                      creditCardButtonBorderColor =
                          DefaultColors.defaultBlueColor;
                      codButtonBorderColor = const Color(0xFFDDDDDD);
                      creditCardIconColor = Colors.white;
                      codIconColor = const Color(0xFFBEBEBE);
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.credit_card_rounded,
                        color: creditCardIconColor,
                        size: 34.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: creditCardButtonColor,
                      border: Border.all(
                          color: creditCardButtonBorderColor, width: 2.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      CheckoutPaymentsScreen.currentScreen = 'COD';
                      creditCardButtonColor = Colors.transparent;
                      codButtonColor = DefaultColors.defaultBlueColor;
                      creditCardButtonBorderColor = const Color(0xFFDDDDDD);
                      codButtonBorderColor = DefaultColors.defaultBlueColor;
                      creditCardIconColor = const Color(0xFFBEBEBE);
                      codIconColor = Colors.white;
                    });
                  },
                  child: Container(
                    child: Center(
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: codIconColor,
                        size: 34.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: codButtonColor,
                      border:
                          Border.all(color: codButtonBorderColor, width: 2.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: CheckoutPaymentsScreen.currentScreen == 'creditCard'
                ? const PaymentsCreditcardScreen()
                : const PaymentsCODScreen(),
          ),
        ),
      ]),
    );
  }
}
