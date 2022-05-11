import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/helper/api_helper.dart';
import 'package:shoppablecard/models/user_model.dart';
import '../helper/shared_preferences_helper.dart';

class LoginService {
  Future<bool> login(
      {required String emailAddress, required String password}) async {
    var userData = await ApiHelper().post(
      url: ApiUrl.userLog,
      postBody: {
        'email': emailAddress,
        'password': password,
      },
    );
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
