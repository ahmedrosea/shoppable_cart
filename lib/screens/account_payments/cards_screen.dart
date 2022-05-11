import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/default_button.dart';
import 'package:shoppablecard/models/credit_card_model.dart';
import 'package:shoppablecard/screens/account_payments/add_card_screen.dart';
import 'package:shoppablecard/screens/account_payments/edit_card_screen.dart';

import '../../state_management/provider.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CardModel> cardsList = context.watch<MyProvider>().creditCardsList;
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
                  'Cards',
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
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditCardScreen(card: cardsList[index])));
                    },
                    child: CreditCardWidget(
                      cardNumber: cardsList[index].cardNumber,
                      expiryDate: cardsList[index].cardExpiryDate,
                      cardHolderName: cardsList[index].cardHolderName,
                      cvvCode: cardsList[index].cardCVV,
                      showBackView: false,
                      cardType: cardsList[index].cardType == 'Visa'
                          ? CardType.visa
                          : CardType.mastercard,
                      glassmorphismConfig: Glassmorphism(
                        blurX: 0.0,
                        blurY: 0.0,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: cardsList[index].cardType == 'Visa'
                              ? <Color>[
                                  const Color(0xFF1AE67B),
                                  const Color(0xFF03C86B)
                                ]
                              : <Color>[
                                  const Color(0xFFF9A33F),
                                  const Color(0xFFF76B1C),
                                ],
                          stops: const <double>[
                            0.5,
                            0.9,
                          ],
                        ),
                      ),
                      obscureCardNumber: false,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      height: 200,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: 'SFPro',
                          fontWeight: FontWeight.w600),
                      width: MediaQuery.of(context).size.width,
                      isChipVisible: false,
                      isSwipeGestureEnabled: false,
                      animationDuration: const Duration(milliseconds: 1000),
                      // ignore: non_constant_identifier_names
                      onCreditCardWidgetChange: (CreditCardBrand) {},
                    ),
                  );
                },
                separatorBuilder: (contex, index) {
                  return const SizedBox(
                    height: 0.0,
                  );
                },
                itemCount: cardsList.length),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.only(right: 20.0, bottom: 10.0, top: 10.0),
            child: SizedBox(
              width: 160.0,
              child: DefaultButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddCardScreen()));
                  },
                  text: 'New'),
            ),
          )
        ],
      ),
    );
  }
}
