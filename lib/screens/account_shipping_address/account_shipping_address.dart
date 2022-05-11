import 'package:flutter/material.dart';
import '../../components/default_button.dart';
import '../../default_colors.dart';

class AccountShipping extends StatefulWidget {
  const AccountShipping({Key? key}) : super(key: key);

  @override
  State<AccountShipping> createState() => _AccountShippingState();
}

class _AccountShippingState extends State<AccountShipping> {
  int activeAddressIndex = 0;
  @override
  Widget build(BuildContext context) {
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
                  width: MediaQuery.of(context).size.width * 0.18,
                ),
                const Text(
                  'Shipping Address',
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Home Address',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFPro',
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Text(
                                '21, Alex Davidson Avenue, Opposite Omegatron, Vicent Smith Quarters, Victoria Island, Lagos, Nigeria',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontFamily: 'SFPro',
                                  height: 1.625,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  activeAddressIndex = index;
                                });
                              },
                              child: Container(
                                height: 23.0,
                                width: 23.0,
                                child: index == activeAddressIndex
                                    ? const Center(
                                        child: Icon(Icons.check_rounded,
                                            size: 18.0, color: Colors.white))
                                    : null,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100.0)),
                                  color: index == activeAddressIndex
                                      ? DefaultColors.defaultBlueColor
                                      : const Color.fromRGBO(0, 0, 0, 0.06),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 30.0,
                  );
                },
                itemCount: 3),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
            child: SizedBox(
              width: 160.0,
              child: DefaultButton(onPressed: () {}, text: 'New'),
            ),
          )
        ],
      ),
    );
  }
}
