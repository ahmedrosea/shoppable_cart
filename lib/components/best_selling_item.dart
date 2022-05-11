import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/screens/product_screen.dart';

import '../state_management/provider.dart';

class BestSellingItem extends StatelessWidget {
  const BestSellingItem({Key? key, required this.productData})
      : super(key: key);

  final ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<MyProvider>().checkAdded(productData: productData);
        context.read<MyProvider>().getCount(productData: productData);
        context.read<MyProvider>().checkFavourites(productData: productData);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(productData: productData)));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.43,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: '${ImagesUrls.products}${productData.productImage}',
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              )),
              errorWidget: (context, url, error) => Center(
                child: Text('$error'),
              ),
              fit: BoxFit.fitHeight,
              width: double.infinity,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              productData.productName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFPro',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(productData.productSubname,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xff929292),
                  fontFamily: 'SFPro',
                )),
            const SizedBox(
              height: 5.0,
            ),
            Text('\$${productData.productPrice}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: DefaultColors.defaultBlueColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFPro',
                )),
          ],
        ),
      ),
    );
  }
}
