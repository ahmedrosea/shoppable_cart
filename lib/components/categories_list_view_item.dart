import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/category_model.dart';
import 'package:shoppablecard/screens/category_result_screen.dart';

class CategoriesListViewItem extends StatelessWidget {
  const CategoriesListViewItem(
      {Key? key,
      required this.itemImage,
      required this.itemTitle,
      required this.categoryData})
      : super(key: key);
  final String itemImage;
  final String itemTitle;
  final CategoryModel categoryData;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryResultScreen(
                      categoryData: categoryData,
                    )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            child: Center(
              child: CachedNetworkImage(
                imageUrl:
                    '${ImagesUrls.categoryUrl}${categoryData.categoryImage}',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            categoryData.categoryTitle,
            style: const TextStyle(
              fontFamily: 'SFPro',
            ),
          ),
        ],
      ),
    );
  }
}
