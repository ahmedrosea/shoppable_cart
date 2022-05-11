// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../components/track_order/track_order_timeline_tile.dart';
import '../../default_colors.dart';

class ViewOrder extends StatelessWidget {
  const ViewOrder(
      {Key? key, required this.statueOfOrder, required this.orderID})
      : super(key: key);
  final String statueOfOrder;
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08,
                      right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 22.0,
                        ),
                      ),
                      Text(
                        orderID,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xff000000),
                          fontFamily: 'SFPro',
                        ),
                      ),
                      Container(
                        height: 45.0,
                        width: 45.0,
                        child: Center(
                          child: Image.asset('assets/images/GPS.png'),
                        ),
                        decoration: BoxDecoration(
                          color: DefaultColors.defaultBlueColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100.0)),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (statueOfOrder == 'Order Signed' ||
                              statueOfOrder == 'Order Processed' ||
                              statueOfOrder == 'Shipped' ||
                              statueOfOrder == 'Out for delivery' ||
                              statueOfOrder == 'Delivered')
                          ? TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Order Signed',
                              isFirst: true,
                              isLast: false,
                              innerColor: DefaultColors.defaultBlueColor,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor: statueOfOrder == 'Order Signed'
                                  ? const Color(0xFFDDDDDD)
                                  : DefaultColors.defaultBlueColor,
                              indicatorBorderColor:
                                  statueOfOrder == 'Order Signed'
                                      ? DefaultColors.defaultBlueColor
                                      : const Color(0xFFDDDDDD),
                            )
                          : TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Order Signed',
                              isFirst: true,
                              isLast: false,
                              innerColor: Colors.transparent,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor: const Color(0xFFDDDDDD),
                              indicatorBorderColor: const Color(0xFFDDDDDD),
                            ),
                      (statueOfOrder == 'Order Processed' ||
                              statueOfOrder == 'Shipped' ||
                              statueOfOrder == 'Out for delivery' ||
                              statueOfOrder == 'Delivered')
                          ? TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Order Processed',
                              isFirst: false,
                              isLast: false,
                              innerColor: DefaultColors.defaultBlueColor,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor: statueOfOrder == 'Order Processed'
                                  ? const Color(0xFFDDDDDD)
                                  : DefaultColors.defaultBlueColor,
                              indicatorBorderColor:
                                  statueOfOrder == 'Order Processed'
                                      ? DefaultColors.defaultBlueColor
                                      : const Color(0xFFDDDDDD),
                            )
                          : const TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Order Processed',
                              isFirst: false,
                              isLast: false,
                              innerColor: Colors.transparent,
                              beforeLineColor: Color(0xFFDDDDDD),
                              afterLineColor: Color(0xFFDDDDDD),
                              indicatorBorderColor: Color(0xFFDDDDDD),
                            ),
                      (statueOfOrder == 'Shipped' ||
                              statueOfOrder == 'Out for delivery' ||
                              statueOfOrder == 'Delivered')
                          ? TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Shipped',
                              isFirst: false,
                              isLast: false,
                              innerColor: DefaultColors.defaultBlueColor,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor: statueOfOrder == 'Shipped'
                                  ? const Color(0xFFDDDDDD)
                                  : DefaultColors.defaultBlueColor,
                              indicatorBorderColor: statueOfOrder == 'Shipped'
                                  ? DefaultColors.defaultBlueColor
                                  : const Color(0xFFDDDDDD),
                            )
                          : const TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Shipped ',
                              isFirst: false,
                              isLast: false,
                              innerColor: Colors.transparent,
                              beforeLineColor: Color(0xFFDDDDDD),
                              afterLineColor: Color(0xFFDDDDDD),
                              indicatorBorderColor: Color(0xFFDDDDDD),
                            ),
                      (statueOfOrder == 'Out for delivery' ||
                              statueOfOrder == 'Delivered')
                          ? TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Out for delivery ',
                              isFirst: false,
                              isLast: false,
                              innerColor: DefaultColors.defaultBlueColor,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor:
                                  statueOfOrder == 'Out for delivery'
                                      ? const Color(0xFFDDDDDD)
                                      : DefaultColors.defaultBlueColor,
                              indicatorBorderColor:
                                  statueOfOrder == 'Out for delivery'
                                      ? DefaultColors.defaultBlueColor
                                      : const Color(0xFFDDDDDD),
                            )
                          : const TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Out for delivery',
                              isFirst: false,
                              isLast: false,
                              innerColor: Colors.transparent,
                              beforeLineColor: Color(0xFFDDDDDD),
                              afterLineColor: Color(0xFFDDDDDD),
                              indicatorBorderColor: Color(0xFFDDDDDD),
                            ),
                      (statueOfOrder == 'Delivered')
                          ? TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Delivered ',
                              isFirst: false,
                              isLast: true,
                              innerColor: DefaultColors.defaultBlueColor,
                              beforeLineColor: DefaultColors.defaultBlueColor,
                              afterLineColor: const Color(0xFFDDDDDD),
                              indicatorBorderColor: statueOfOrder == 'Delivered'
                                  ? DefaultColors.defaultBlueColor
                                  : const Color(0xFFDDDDDD),
                            )
                          : const TrackOrderTimeLineTile(
                              date: '20/08',
                              time: '10:00 AM',
                              orderState: 'Delivered ',
                              isFirst: false,
                              isLast: true,
                              innerColor: Colors.transparent,
                              beforeLineColor: Color(0xFFDDDDDD),
                              afterLineColor: Color(0xFFDDDDDD),
                              indicatorBorderColor: Color(0xFFDDDDDD),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
