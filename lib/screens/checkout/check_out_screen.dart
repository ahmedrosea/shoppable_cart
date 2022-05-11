import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/check_out/check_out_timeline_tile.dart';
import 'package:shoppablecard/components/default_button.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/screens/checkout/check_out_address_screen.dart';
import 'package:shoppablecard/screens/checkout/check_out_delivery_screen.dart';
import 'package:shoppablecard/screens/checkout/checkout_summary_screen.dart';
import 'package:shoppablecard/screens/checkout/payments/check_out_payments_screen.dart';
import 'package:shoppablecard/state_management/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<Widget> checkoutScreens = [
    const CheckoutDeliveryScreen(),
    const CheckoutAddressScreen(),
    const CheckoutPaymentsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    int screenIndex = context.watch<MyProvider>().checkoutScreenIndex;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<MyProvider>().setCheckoutScreenIndex(index: 0);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'SFPro',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                screenIndex >= 0
                    ? CheckoutTimeline(
                        step: 'Delivery',
                        isFirst: true,
                        isLast: false,
                        innerColor: DefaultColors.defaultBlueColor,
                        beforeLineColor: const Color(0xFFDDDDDD),
                        afterLineColor: screenIndex > 0
                            ? DefaultColors.defaultBlueColor
                            : const Color(0xFFDDDDDD),
                        indicatorBorderColor: screenIndex == 0
                            ? DefaultColors.defaultBlueColor
                            : const Color(0xFFDDDDDD))
                    : CheckoutTimeline(
                        step: 'Delivery',
                        isFirst: true,
                        isLast: false,
                        innerColor: DefaultColors.defaultBlueColor,
                        beforeLineColor: const Color(0xFFDDDDDD),
                        afterLineColor: const Color(0xFFDDDDDD),
                        indicatorBorderColor: const Color(0xFFDDDDDD)),
                screenIndex >= 1
                    ? CheckoutTimeline(
                        step: 'Address',
                        isFirst: false,
                        isLast: false,
                        innerColor: DefaultColors.defaultBlueColor,
                        beforeLineColor: DefaultColors.defaultBlueColor,
                        afterLineColor: screenIndex > 1
                            ? DefaultColors.defaultBlueColor
                            : const Color(0xFFDDDDDD),
                        indicatorBorderColor: screenIndex == 1
                            ? DefaultColors.defaultBlueColor
                            : const Color(0xFFDDDDDD))
                    : const CheckoutTimeline(
                        step: 'Address',
                        isFirst: false,
                        isLast: false,
                        innerColor: Colors.transparent,
                        beforeLineColor: Color(0xFFDDDDDD),
                        afterLineColor: Color(0xFFDDDDDD),
                        indicatorBorderColor: Color(0xFFDDDDDD)),
                screenIndex >= 2
                    ? CheckoutTimeline(
                        step: 'Payments',
                        isFirst: false,
                        isLast: true,
                        innerColor: DefaultColors.defaultBlueColor,
                        beforeLineColor: DefaultColors.defaultBlueColor,
                        afterLineColor: const Color(0xFFDDDDDD),
                        indicatorBorderColor: screenIndex == 2
                            ? DefaultColors.defaultBlueColor
                            : const Color(0xFFDDDDDD))
                    : const CheckoutTimeline(
                        step: 'Payments',
                        isFirst: false,
                        isLast: true,
                        innerColor: Colors.transparent,
                        beforeLineColor: Color(0xFFDDDDDD),
                        afterLineColor: Color(0xFFDDDDDD),
                        indicatorBorderColor: Color(0xFFDDDDDD)),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: checkoutScreens[screenIndex],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(right: 25.0, bottom: 15.0, left: 25.0),
            height: 70.0,
            child: Row(
              children: [
                Expanded(
                  child: screenIndex > 0
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              if (screenIndex > 0) {
                                context
                                    .read<MyProvider>()
                                    .checkoutScreenIndexDecrement();
                              }
                            });
                          },
                          child: Container(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                'Back'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(
                                  color: DefaultColors.defaultBlueColor,
                                  width: 2.0),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: DefaultButton(
                      text: 'next',
                      onPressed: () {
                        setState(() {
                          if (screenIndex == 1) {
                            if (CheckoutScreen.formKey.currentState!
                                .validate()) {
                              context.read<MyProvider>().setShippingAddress(
                                  street1: CheckoutAddressScreen
                                      .street1Controller.text,
                                  street2: CheckoutAddressScreen
                                      .street2Controller.text,
                                  city:
                                      CheckoutAddressScreen.cityController.text,
                                  state: CheckoutAddressScreen
                                      .stateController.text,
                                  country: CheckoutAddressScreen
                                      .countryController.text);
                              context
                                  .read<MyProvider>()
                                  .checkoutScreenIndexIncrement();
                            }
                          } else if (screenIndex ==
                              checkoutScreens.length - 1) {
                            if (CheckoutPaymentsScreen.currentScreen ==
                                'creditCard') {
                              if (CheckoutScreen.formKey.currentState!
                                  .validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutSummaryScreen(
                                                paymentType: 'creditCard')));
                              }
                              null;
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckoutSummaryScreen(
                                              paymentType:
                                                  'Cash on delivery')));
                            }
                          } else {
                            context
                                .read<MyProvider>()
                                .checkoutScreenIndexIncrement();
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
