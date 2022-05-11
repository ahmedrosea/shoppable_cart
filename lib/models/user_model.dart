class UserModel {
  final String fullName;
  final String emailAddress;
  final String phone;
  final String image;
  final String currency;
  final String languageCode;
  final String subscriptionkey;
  final String isActive;
  final String userID;
  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.phone,
    required this.image,
    required this.languageCode,
    required this.currency,
    required this.subscriptionkey,
    required this.isActive,
    required this.userID,
  });

  factory UserModel.fromJson(jsonData) {
    return UserModel(
      fullName: jsonData['fullname'],
      emailAddress: jsonData['email'],
      phone: jsonData['phone'],
      image: jsonData['image'],
      languageCode: jsonData['languageCode'],
      currency: jsonData['currency'],
      subscriptionkey: jsonData['subscriptionkey'],
      isActive: jsonData['isActive'],
      userID: jsonData['user_id'],
    );
  }
}
