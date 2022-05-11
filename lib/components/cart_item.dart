import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/state_management/provider.dart';

import '../default_colors.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: double.infinity,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${ImagesUrls.products}${widget.product.productImage}',
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
          const SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.productName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  '\$${widget.product.productPrice}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: DefaultColors.defaultBlueColor,
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 100.0,
                  height: 30.0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            context
                                .read<MyProvider>()
                                .incrementCartCount(product: widget.product);
                          },
                          child: SizedBox(
                              height: double.infinity,
                              child: Image.asset('assets/images/plus.png')),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.count.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'SFPro',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            context
                                .read<MyProvider>()
                                .decrementCartCount(product: widget.product);
                          },
                          child: SizedBox(
                              height: double.infinity,
                              child: Image.asset('assets/images/minus.png')),
                        ),
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
