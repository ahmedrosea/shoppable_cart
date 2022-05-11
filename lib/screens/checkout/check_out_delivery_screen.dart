import 'package:flutter/material.dart';
import 'package:shoppablecard/default_colors.dart';

class CheckoutDeliveryScreen extends StatefulWidget {
  const CheckoutDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutDeliveryScreen> createState() => _CheckoutDeliveryScreenState();
}

class _CheckoutDeliveryScreenState extends State<CheckoutDeliveryScreen> {
  int _value = 2;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Standart Delivery',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFPro',
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Text(
                        'Order will be delivered between 3 - 5 business days',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          height: 1.6428571428571428,
                          fontFamily: 'SFPro',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.4,
                  child: Radio<int>(
                    activeColor: DefaultColors.defaultBlueColor,
                    value: 1,
                    groupValue: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Next Day Delivery',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFPro',
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Text(
                        'Place your order before 6pm and your items will be delivered the next day',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          height: 1.6428571428571428,
                          fontFamily: 'SFPro',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.4,
                  child: Radio<int>(
                    value: 2,
                    activeColor: DefaultColors.defaultBlueColor,
                    groupValue: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Nominated Delivery',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFPro',
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Text(
                        'Pick a particular date from the calendar and order will be delivered on selected date',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          height: 1.6428571428571428,
                          fontFamily: 'SFPro',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.4,
                  child: Radio<int>(
                    value: 3,
                    activeColor: DefaultColors.defaultBlueColor,
                    groupValue: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
