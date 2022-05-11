import 'package:flutter/material.dart';
import 'package:shoppablecard/default_colors.dart';

class PaymentsCODScreen extends StatelessWidget {
  const PaymentsCODScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150.0,
                width: 150.0,
                child: const Center(
                    child: Icon(Icons.check_rounded,
                        size: 130.0, color: Colors.white)),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  color: DefaultColors.defaultBlueColor,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'you choosed\nCash on delivery',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36.0,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFPro',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
