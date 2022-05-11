import 'package:flutter/material.dart';
import 'package:shoppablecard/components/categories_list_view.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          CategoriesListView(),
        ],
      ),
    );
  }
}
