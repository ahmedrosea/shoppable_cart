import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/helper/api_helper.dart';
import 'package:shoppablecard/models/user_orders_model.dart';

class GetOrdersHistoryService {
  Future<List<UserOrdersModel>> getOrderHistory(
      {required String userID}) async {
    String url = '${ApiUrl.userOrders}$userID';
    var data = await ApiHelper().get(url);
    List<UserOrdersModel> userOrders = [];
    for (int i = 0; i < data.length; i++) {
      UserOrdersModel userOrder = UserOrdersModel.fromJson(data[i]);
      userOrders.add(userOrder);
    }
    return userOrders;
  }
}
