

class CardModel{
  final String cardHolderName;
  final String cardNumber;
  final String cardExpiryDate;
  final String cardCVV;
  final String cardType;

  CardModel({required this.cardHolderName, required this.cardNumber, required this.cardExpiryDate, required this.cardCVV, required this.cardType});

  factory CardModel.fromData(data){
    return CardModel(cardHolderName: data["cardHolderName"], cardNumber: data["cardNumber"], cardExpiryDate: data["cardExpiryDate"], cardCVV: data["cardCVV"], cardType: data["cardType"]);
  }
}