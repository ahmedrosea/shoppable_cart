import 'package:flutter/material.dart';
import 'package:shoppablecard/components/best_selling_items_view.dart';

class BestSellingSection extends StatelessWidget {
  const BestSellingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Best Selling',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 17.0,
                      color: Colors.black,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          BestSellingItemView(),
        ],
      ),
    );
  }
}
