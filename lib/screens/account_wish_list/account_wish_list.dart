import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/screens/product_screen.dart';
import 'package:shoppablecard/state_management/provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProductModel> wishList = context.watch<MyProvider>().wishList;
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
                  'Wishlist',
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
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            itemBuilder: (contex, index) {
              return InkWell(
                onTap: () {
                  context
                      .read<MyProvider>()
                      .checkAdded(productData: wishList[index]);
                  context
                      .read<MyProvider>()
                      .getCount(productData: wishList[index]);
                  context
                      .read<MyProvider>()
                      .checkFavourites(productData: wishList[index]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductScreen(productData: wishList[index])));
                },
                child: Container(
                  height: 125.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${ImagesUrls.products}${wishList[index].productImage}',
                        placeholder: (context, url) => const Center(
                            child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 30.0,
                          width: 30.0,
                        )),
                        errorWidget: (context, url, error) => Center(
                          child: Text('$error'),
                        ),
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                wishList[index].productName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'SFPro',
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '\$${wishList[index].productPrice}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'SFPro',
                                    color: DefaultColors.defaultBlueColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemCount: wishList.length,
          )),
        ],
      ),
    );
  }
}
