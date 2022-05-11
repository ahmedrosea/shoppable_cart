import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/cart_item.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/state_management/provider.dart';

import '../components/default_button.dart';
import 'checkout/check_out_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    context.read<MyProvider>().calculateTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _total = context.watch<MyProvider>().total;
    List<ProductModel> cartItems = context.watch<MyProvider>().cartList;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            cartItems.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: MediaQuery.of(context).size.height * 0.07),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        context
                                            .read<MyProvider>()
                                            .addToFavourite(
                                                productData: cartItems[index]);
                                      },
                                      icon: Icons.star,
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xFFFFC107),
                                    )
                                  ]),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.25,
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        context
                                            .read<MyProvider>()
                                            .deleteCartProduct(
                                                product: cartItems[index]);
                                        context.read<MyProvider>().getCart();
                                        context
                                            .read<MyProvider>()
                                            .calculateTotal();
                                      });
                                    },
                                    icon: Icons.delete_outline,
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xFFFF3D00),
                                  ),
                                ],
                              ),
                              child: CartItem(product: cartItems[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20.0,
                            );
                          },
                          itemCount: cartItems.length),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'The cart is Empty',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFPro',
                          color: DefaultColors.defaultBlueColor,
                        ),
                      ),
                    ),
                  ),
            BottomSheet(
              enableDrag: false,
              backgroundColor: Colors.white,
              constraints: BoxConstraints(
                  maxHeight: (MediaQuery.of(context).size.height * 0.11),
                  maxWidth: double.infinity),
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'SFPro',
                              color: Color(0xff929292),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '\$${_total.toString()}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.w700,
                              color: DefaultColors.defaultBlueColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 50.0,
                      ),
                      SizedBox(
                        child: DefaultButton(
                          text: 'checkout'.toUpperCase(),
                          onPressed: () {
                            if (cartItems.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckoutScreen()));
                            }
                          },
                        ),
                        width: (MediaQuery.of(context).size.width * 0.4),
                      )
                    ],
                  ),
                );
              },
              onClosing: () {},
            ),
          ],
        ),
      ),
    );
  }
}
