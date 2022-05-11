class UserOrdersModel {
  final String id;
  final String orderID;
  final String userID;
  final String products;
  final String totalPrice;
  final String dateTime;
  final String status;

  UserOrdersModel(
      {required this.id,
      required this.orderID,
      required this.userID,
      required this.products,
      required this.totalPrice,
      required this.dateTime,
      required this.status});

  factory UserOrdersModel.fromJson(jsonData) {
    return UserOrdersModel(
        id: jsonData["id"],
        orderID: jsonData["order_id"],
        userID: jsonData["user_id"],
        products: jsonData["products"],
        totalPrice: jsonData["total_price"],
        dateTime: jsonData["date_time"],
        status: jsonData["status"]);
  }
}
