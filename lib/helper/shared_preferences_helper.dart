import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SharedPreferencesHelper {
  String? fullName;
  String? emailAddress;
  String? phone;
  String? image;
  String? currency;
  String? languageCode;
  String? subscriptionkey;
  String? isActive;
  SharedPreferencesHelper(
      {this.fullName,
      this.emailAddress,
      this.phone,
      this.image,
      this.currency,
      this.languageCode,
      this.subscriptionkey,
      this.isActive});
  Future<SharedPreferences> init() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference;
  }

  Future putString({required String key, required String data}) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    await sharedPreference.setString(key, data);
  }

  Future putBool({required String key, required bool data}) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    await sharedPreference.setBool(key, data);
  }

  Future putInteger({required String key, required int data}) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    await sharedPreference.setInt(key, data);
  }

  Future<String?> getString({required String key}) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();
    return sharedPreference.getString(key);
  }

  Future setLoggedInUserData({required UserModel user}) async {
    await putString(key: 'userFullName', data: user.fullName);
    await putString(key: 'userEmail', data: user.emailAddress);
    await putString(key: 'userPhone', data: user.phone);
    await putString(key: 'userImage', data: user.image);
    await putString(key: 'userLanguageCode', data: user.languageCode);
    await putString(key: 'userCurrency', data: user.currency);
    await putString(key: 'userSubscriptionkey', data: user.subscriptionkey);
    await putString(key: 'userIsActive', data: user.isActive);
    await putString(key: 'userID', data: user.userID);
  }
}
