import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrderTimeLineTile extends StatelessWidget {
  const TrackOrderTimeLineTile(
      {Key? key,
      required this.date,
      required this.time,
      required this.orderState,
      required this.isFirst,
      required this.isLast,
      required this.innerColor,
      required this.beforeLineColor,
      required this.afterLineColor,
      required this.indicatorBorderColor})
      : super(key: key);
  final String date;
  final String time;
  final String orderState;
  final bool isFirst;
  final bool isLast;
  final Color innerColor;
  final Color afterLineColor;
  final Color beforeLineColor;
  final Color indicatorBorderColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: TimelineTile(
          alignment: TimelineAlign.center,
          startChild: SizedBox(
            width: 50.0,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xff929292),
                      fontSize: 14.0,
                      fontFamily: 'SFPro',
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    time,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xff929292),
                      fontSize: 14.0,
                      fontFamily: 'SFPro',
                    ),
                  ),
                ],
              ),
            ),
          ),
          endChild: Container(
            padding: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              orderState,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFPro',
              ),
            ),
          ),
          indicatorStyle: IndicatorStyle(
              width: 35.0,
              height: 35.0,
              padding: const EdgeInsets.all(0.1),
              indicator: Container(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: innerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: indicatorBorderColor, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                ),
              )),
          isFirst: isFirst,
          isLast: isLast,
          afterLineStyle: LineStyle(color: afterLineColor, thickness: 2.0),
          beforeLineStyle: LineStyle(
            color: beforeLineColor,
            thickness: 2.0,
          ),
        ),
      ),
    );
  }
}
