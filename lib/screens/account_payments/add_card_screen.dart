import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/models/credit_card_model.dart';

import '../../components/default_button.dart';
import '../../default_colors.dart';
import '../../state_management/provider.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardHolderName = '';
  String expiryDate = '';
  String cardNumber = '';
  String cardCVV = '';
  String? cardSystem = '';
  bool showback = false;

  void onCardModelChange(CreditCardModel creditCard) {
    setState(() {
      cardHolderName = creditCard.cardHolderName;
      expiryDate = creditCard.expiryDate;
      cardNumber = creditCard.cardNumber;
      cardSystem = getCardSystemData(cardNumber)?.system ?? 'Mastercard';
      cardCVV = creditCard.cvvCode;
      showback = creditCard.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                'Add Card',
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
        SingleChildScrollView(
          child: CreditCardWidget(
            obscureCardCvv: false,
            glassmorphismConfig: Glassmorphism(
              blurX: 0.0,
              blurY: 0.0,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: cardSystem == 'Visa'
                    ? <Color>[const Color(0xFF1AE67B), const Color(0xFF03C86B)]
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
            isChipVisible: false,
            isHolderNameVisible: true,
            obscureCardNumber: false,
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            cvvCode: cardCVV,
            expiryDate: expiryDate,
            onCreditCardWidgetChange: (creditCardBrand) {},
            showBackView: showback,
            height: 200,
            isSwipeGestureEnabled: false,
            animationDuration: const Duration(milliseconds: 500),
          ),

          /*CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cardCVV,
                  showBackView: false,
                  cardType: cardSystem=='Mastercard'?CardType.mastercard:(cardSystem == 'Visa'?CardType.visa: null),
                  glassmorphismConfig: Glassmorphism(
                      blurX: 0.0,
                      blurY: 0.0,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: cardSystem == 'Visa'?<Color>[
                            const Color(0xFF1AE67B),
                            const Color(0xFF03C86B)
                          ]:<Color>[
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
                  obscureCardCvv: false,
                  isHolderNameVisible: true,
                  height: 200,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'SFPro', fontWeight: FontWeight.w600),
                  width: MediaQuery.of(context).size.width,
                  isChipVisible: false,
                  isSwipeGestureEnabled: false,
                  animationDuration: const Duration(milliseconds: 500), onCreditCardWidgetChange: (CreditCardBrand ) {  },
                    ),*/
        ),
        Expanded(
          child: SingleChildScrollView(
            child: CreditCardForm(
              formKey: formKey, // Required
              onCreditCardModelChange: onCardModelChange, // Required
              themeColor: Colors.red,
              obscureCvv: false,
              obscureNumber: false,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardNumberDecoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontFamily: 'SFPro',
                ),
                labelStyle: const TextStyle(
                  color: Color(0x80000000),
                  fontFamily: 'SFPro',
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontFamily: 'SFPro',
                ),
                labelStyle: const TextStyle(
                  color: Color(0x80000000),
                  fontFamily: 'SFPro',
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontFamily: 'SFPro',
                ),
                labelStyle: const TextStyle(
                  color: Color(0x80000000),
                  fontFamily: 'SFPro',
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                errorStyle: const TextStyle(
                  fontFamily: 'SFPro',
                ),
                labelStyle: const TextStyle(
                  color: Color(0x80000000),
                  fontFamily: 'SFPro',
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: DefaultColors.defaultBlueColor,
                  ),
                ),
                labelText: 'Card Holder',
              ),
              cardHolderName: cardHolderName,
              cardNumber: cardNumber,
              cvvCode: cardCVV,
              expiryDate: expiryDate,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 25.0, bottom: 15.0, left: 25.0),
          height: 70.0,
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
                        'Cancel'.toUpperCase(),
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
                          color: DefaultColors.defaultBlueColor, width: 2.0),
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
                    text: 'Add',
                    onPressed: () {
                      if (cardNumber.length >= 19 &&
                          cardCVV.length >= 3 &&
                          cardHolderName.isNotEmpty &&
                          expiryDate.length >= 5) {
                        CardModel card = CardModel(
                            cardHolderName: cardHolderName,
                            cardNumber: cardNumber,
                            cardExpiryDate: expiryDate,
                            cardCVV: cardCVV,
                            cardType: cardSystem!);
                        context
                            .read<MyProvider>()
                            .addToCreditCards(cardData: card);
                        context.read<MyProvider>().getCards();
                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Card Data',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.w700,
                                  color: DefaultColors.defaultBlueColor,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text(
                                      'Card Data can\'t be empty',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'SFPro',
                                          color: Colors.red,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'SFPro',
                                        color: DefaultColors.defaultBlueColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
