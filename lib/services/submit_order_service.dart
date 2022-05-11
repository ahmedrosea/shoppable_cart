import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/helper/api_helper.dart';

class SubmitOrderService {
  Future<bool> submitOrder(
      {required String userID,
      required String products,
      required String totalPrice}) async {
    var data = await ApiHelper().post(
      url: ApiUrl.newOrder,
      postBody: {
        'user_id': userID,
        'products': products,
        'total_price': totalPrice
      },
    );
    if (data["success"] == true) {
      return true;
    } else {
      return false;
    }
  }
}
