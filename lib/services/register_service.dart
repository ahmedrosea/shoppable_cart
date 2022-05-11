import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/helper/api_helper.dart';
import 'package:shoppablecard/helper/shared_preferences_helper.dart';
import 'package:shoppablecard/models/user_model.dart';

class RegisterService {
  // ignore: non_constant_identifier_names
  Future<bool> Register(
      {required String emailAddress,
      required String fullName,
      required String password}) async {
    var userData = await ApiHelper().post(url: ApiUrl.userReg, postBody: {
      'email': emailAddress,
      'password': password,
      'fullname': fullName
    });
    if (userData["success"] == true) {
      UserModel user = UserModel.fromJson(userData);
      await SharedPreferencesHelper().setLoggedInUserData(user: user);
      SharedPreferencesHelper().putBool(key: 'isLoggedIn', data: true);
      return true;
    } else {
      return false;
    }
  }
}
