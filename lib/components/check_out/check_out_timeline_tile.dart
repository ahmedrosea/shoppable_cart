import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';




class CheckoutTimeline extends StatelessWidget {
  const CheckoutTimeline({ Key? key,  
                          required this.step,
                          required this.isFirst, 
                          required this.isLast, 
                          required this.innerColor, 
                          required this.beforeLineColor, 
                          required this.afterLineColor, 
                          required this.indicatorBorderColor,
                           }) : super(key: key);
  final bool isFirst;
  final bool isLast;
  final Color innerColor;
  final Color afterLineColor;
  final Color beforeLineColor;
  final Color indicatorBorderColor;
  final String step;
  @override
  Widget build(BuildContext context) {
    return Align(
            child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width*0.33, 
            child: TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              endChild: Container(
                alignment: Alignment.center,
                child: Text(
                  step,
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
                width: 32.0,
                height: 32.0,
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
                )
              ),
              isFirst: isFirst,
              isLast: isLast,
              afterLineStyle: LineStyle(
                color: afterLineColor,
                thickness: 2.0
              ),
              beforeLineStyle: LineStyle(
                color: beforeLineColor,
                thickness: 2.0,
              ),
            ),
          ),
    );
  }
}