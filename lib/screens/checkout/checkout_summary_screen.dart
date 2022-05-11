import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/default_colors.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/screens/home_screen.dart';
import 'package:shoppablecard/screens/product_screen.dart';
import 'package:shoppablecard/services/submit_order_service.dart';

import '../../components/default_button.dart';
import '../../state_management/provider.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  const CheckoutSummaryScreen({Key? key, required this.paymentType})
      : super(key: key);

  final String paymentType;

  @override
  State<CheckoutSummaryScreen> createState() => _CheckoutSummaryScreenState();
}

class _CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    String cardNumber = context.watch<MyProvider>().cardNumber;
    String? cardSystem = context.watch<MyProvider>().cardSystem;
    String shippingAddress = context.watch<MyProvider>().shippingAddress;
    List<ProductModel> cartList = context.watch<MyProvider>().cartList;
    String userID = context.watch<MyProvider>().userID;
    String cartProductsIDs = context.watch<MyProvider>().cartProductsIDs;
    String totalPrice = context.watch<MyProvider>().total.toString();
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.81,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.08),
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
                                'Summary',
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
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.226,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<MyProvider>()
                                      .checkAdded(productData: cartList[index]);
                                  context
                                      .read<MyProvider>()
                                      .getCount(productData: cartList[index]);
                                  context.read<MyProvider>().checkFavourites(
                                      productData: cartList[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                              productData: cartList[index])));
                                },
                                child: SizedBox(
                                  width: 95,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            '${ImagesUrls.products}${cartList[index].productImage}',
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: SizedBox(
                                          child: CircularProgressIndicator(),
                                          height: 30.0,
                                          width: 30.0,
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: Text('$error'),
                                        ),
                                        fit: BoxFit.contain,
                                        height: 100,
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          cartList[index].productName,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'SFPro',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        '\$${cartList[index].productPrice}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'SFPro',
                                          color: DefaultColors.defaultBlueColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 20.0,
                              );
                            },
                            itemCount: cartList.length,
                          ),
                        ),
                        const Divider(
                          height: 50.0,
                          thickness: 1,
                          color: Color(0xFFEBEBEB),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shipping Address',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFPro',
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      shippingAddress,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontFamily: 'SFPro',
                                        height: 1.625,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 23.0,
                                    width: 23.0,
                                    child: const Center(
                                        child: Icon(Icons.check_rounded,
                                            size: 18.0, color: Colors.white)),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(100.0)),
                                      color: DefaultColors.defaultBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<MyProvider>()
                                      .setCheckoutScreenIndex(index: 1);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: DefaultColors.defaultBlueColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 50.0,
                          thickness: 1,
                          color: Color(0xFFEBEBEB),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Payment',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFPro',
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(children: [
                                widget.paymentType == 'Cash on delivery'
                                    ? Text(
                                        'COD',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'SFPro',
                                          color: DefaultColors.defaultBlueColor,
                                        ),
                                      )
                                    : (cardSystem == 'Mastercard'
                                        ? Image.asset(
                                            'assets/images/mastercard.png',
                                            width: 60.0,
                                          )
                                        : Image.asset(
                                            'assets/images/visa.png',
                                            width: 60.0,
                                          )),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                widget.paymentType == 'Cash on delivery'
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cardSystem!,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xff929292),
                                              fontFamily: 'SFPro',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3.0,
                                          ),
                                          Text(
                                            '**** **** **** ${cardNumber.substring(cardNumber.length - 4, cardNumber.length)}',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontFamily: 'SFPro',
                                            ),
                                          ),
                                        ],
                                      ),
                                const Spacer(),
                                Container(
                                  height: 23.0,
                                  width: 23.0,
                                  child: const Center(
                                      child: Icon(Icons.check_rounded,
                                          size: 18.0, color: Colors.white)),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100.0)),
                                    color: DefaultColors.defaultBlueColor,
                                  ),
                                ),
                              ]),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: DefaultColors.defaultBlueColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'SFPro',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      right: 25.0, bottom: 5.0, left: 25.0),
                  height: 60.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                'Back'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(
                                  color: DefaultColors.defaultBlueColor,
                                  width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: DefaultButton(
                            text: widget.paymentType == 'Cash on delivery'
                                ? 'Submit'
                                : 'Pay',
                            onPressed: () {
                              widget.paymentType == 'Cash on delivery'
                                  ? setState(() {
                                      _loading = true;
                                    })
                                  : null;
                              widget.paymentType == 'Cash on delivery'
                                  ? SubmitOrderService()
                                      .submitOrder(
                                      userID: userID,
                                      products: cartProductsIDs,
                                      totalPrice: totalPrice,
                                    )
                                      .then((value) {
                                      if (value) {
                                        setState(() {
                                          _loading = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Successful',
                                                  style: TextStyle(
                                                    fontFamily: 'SFPro',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                content: Text(
                                                  'Your Order Successfully Submited',
                                                  style: TextStyle(
                                                    color: DefaultColors
                                                        .defaultBlueColor,
                                                    fontFamily: 'SFPro',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<MyProvider>()
                                                            .deleteAllCartProducts();
                                                        Navigator
                                                            .pushAndRemoveUntil<
                                                                void>(
                                                          context,
                                                          MaterialPageRoute<
                                                                  void>(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  const HomeScreen()),
                                                          ModalRoute.withName(
                                                              '/'),
                                                        );
                                                      },
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          color: DefaultColors
                                                              .defaultBlueColor,
                                                          fontFamily: 'SFPro',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ))
                                                ],
                                              );
                                            });
                                        context
                                            .read<MyProvider>()
                                            .getAllUserOrders();
                                        context
                                            .read<MyProvider>()
                                            .setCheckoutScreenIndex(index: 0);
                                      } else {
                                        setState(() {
                                          _loading = false;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'error!',
                                                  style: TextStyle(
                                                    fontFamily: 'SFPro',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                content: const Text(
                                                  'There\'s something went wrong!',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'SFPro',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          color: DefaultColors
                                                              .defaultBlueColor,
                                                          fontFamily: 'SFPro',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ))
                                                ],
                                              );
                                            });
                                      }
                                    })
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
