import 'package:flutter/material.dart';
import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/models/category_model.dart';
import '../components/best_selling_item.dart';
import '../helper/api_helper.dart';
import '../models/product_model.dart';

class CategoryResultScreen extends StatelessWidget {
  CategoryResultScreen({Key? key, required this.categoryData})
      : super(key: key);
  final CategoryModel categoryData;

  final List<ProductModel> products = [];

  Future<List<ProductModel>> getCategoryProducts() async {
    List<dynamic> data = await ApiHelper()
        .get('${ApiUrl.catProducts}${categoryData.categoryId}');
    List<ProductModel> categoryProducts = [];
    for (int i = 0; i < data.length; i++) {
      categoryProducts.add(ProductModel.fromJson(data[i]));
    }
    return categoryProducts;
  }

  Future<List<Widget>> getCategoryItems() async {
    List<ProductModel> categoryProducts = await getCategoryProducts();
    List<Widget> list = [];
    for (int i = 0; i < categoryProducts.length; i += 2) {
      list.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: BestSellingItem(
              productData: categoryProducts[i],
            )),
            const SizedBox(
              width: 15.0,
            ),
            (((i + 1) % 2) == 0)
                ? Expanded(
                    child: BestSellingItem(
                    productData: categoryProducts[i + 1],
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.3),
                      child: Text(
                        categoryData.categoryTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List<Widget>>(
                  future: getCategoryItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget>? data = snapshot.data;
                      return Column(
                        children: data!,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Text('');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
