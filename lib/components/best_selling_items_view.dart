import 'package:flutter/material.dart';
import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/components/best_selling_item.dart';
import 'package:shoppablecard/helper/api_helper.dart';
import 'package:shoppablecard/models/product_model.dart';

class BestSellingItemView extends StatelessWidget {
  BestSellingItemView({Key? key}) : super(key: key);
  final List<ProductModel> products = [];

  Future<List<ProductModel>> getBestSellingProducts() async {
    List<dynamic> data = await ApiHelper().get(ApiUrl.bestSelling);
    List<ProductModel> bestSellingProducts = [];
    for (int i = 0; i < data.length; i++) {
      bestSellingProducts.add(ProductModel.fromJson(data[i]));
    }
    return bestSellingProducts;
  }

  Future<List<Widget>> getBestSellingItems() async {
    List<ProductModel> bestSellingProducts = await getBestSellingProducts();
    List<Widget> list = [];
    for (int i = 0; i < bestSellingProducts.length; i += 2) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: BestSellingItem(
              productData: bestSellingProducts[i],
            )),
            const SizedBox(
              width: 15.0,
            ),
            (((i + 1) / 2) != 0)
                ? Expanded(
                    child: BestSellingItem(
                    productData: bestSellingProducts[i + 1],
                  ))
                : const Expanded(child: SizedBox()),
          ],
        ),
      );
      list.add(const SizedBox(
        height: 20.0,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder<List<Widget>>(
          future: getBestSellingItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Widget>? data = snapshot.data;
              return Column(
                children: data!,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Text('');
          }),
    );
  }
}
