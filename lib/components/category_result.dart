import 'package:flutter/material.dart';

class CategoryResult extends StatelessWidget {
  const CategoryResult({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
          ),
          const Text(
            'Men ',
            style: TextStyle(fontSize: 20, fontFamily: 'SFPro'),
          )
        ],
      ),
    );
  }
}
