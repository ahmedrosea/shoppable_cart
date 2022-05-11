import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/models/user_orders_model.dart';
import 'package:shoppablecard/screens/Account%20_Track_Order/track%20order%20_view%20order.dart';
import 'package:shoppablecard/state_management/provider.dart';
import '../../api.dart';
import '../../default_colors.dart';
import '../../helper/api_helper.dart';
import '../../images.dart';
import '../../models/product_model.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    List<UserOrdersModel> userOrders =
        context.watch<MyProvider>().userOrdersHistory;
    List<String> productsIDs = context.read<MyProvider>().productsIDs;
    List<String> productsImages = context.read<MyProvider>().productsImages;
    return Scaffold(
      body: SizedBox(
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
                    width: MediaQuery.of(context).size.width * 0.22,
                  ),
                  const Text(
                    'Track Order',
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
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewOrder(
                                    statueOfOrder: userOrders[index].status,
                                    orderID: userOrders[index].orderID,
                                  )));
                    },
                    child: Container(
                      alignment: const Alignment(-0.11, 0.03),
                      width: 343.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF242424).withOpacity(0.05),
                            offset: const Offset(0, 5.0),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 343.0,
                        height: 105.0,
                        child: Row(
                          children: <Widget>[
                            const Spacer(flex: 20),
                            SizedBox(
                              width: 143.0,
                              height: 105.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    userOrders[index].orderID,
                                    style: const TextStyle(
                                      fontFamily: 'SFPro',
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(flex: 8),
                                  Text(
                                    '\$${userOrders[index].totalPrice}',
                                    style: const TextStyle(
                                      fontFamily: 'SFPro',
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Spacer(flex: 27),
                                  // Group: Delivered
                                  Container(
                                    alignment: const Alignment(0.0, -0.09),
                                    width: 80.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.0),
                                      color: const Color(0xff00c569),
                                    ),
                                    child: Text(
                                      userOrders[index].status,
                                      style: const TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 11.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(flex: 48),
                            CachedNetworkImage(
                              imageUrl:
                                  '${ImagesUrls.products}${productsImages[productsIDs.indexOf(userOrders[index].products.substring(1, 4))]}',
                              placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                child: CircularProgressIndicator(),
                                height: 30.0,
                                width: 30.0,
                              )),
                              errorWidget: (context, url, error) => Center(
                                child: Text('$error'),
                              ),
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                            const Spacer(flex: 26),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20.0,
                  );
                },
                itemCount: userOrders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
