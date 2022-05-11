import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppablecard/models/credit_card_model.dart';
import 'package:shoppablecard/models/user_orders_model.dart';
import 'package:shoppablecard/services/get_orders_history_service.dart';
import '../api.dart';
import '../helper/api_helper.dart';
import '../models/product_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class MyProvider with ChangeNotifier {
  List<ProductModel> cartList = [];
  String cartProductsIDs = "";
  late int total;
  late bool isAdded;
  int? count;
  bool isFavourite = false;

  //checkout screen index

  int checkoutScreenIndex = 0;

  void setCheckoutScreenIndex({required int index}) {
    checkoutScreenIndex = index;
    notifyListeners();
  }

  void checkoutScreenIndexIncrement() {
    checkoutScreenIndex++;
    notifyListeners();
  }

  void checkoutScreenIndexDecrement() {
    checkoutScreenIndex--;
    notifyListeners();
  }

  //shipping address
  String shippingAddress = '';

  void setShippingAddress(
      {required String street1,
      required String street2,
      required String city,
      required String state,
      required String country}) {
    shippingAddress = '$street1, $street2, $city, $state, $country';
  }

  //creditCardNumber
  String cardName = '';
  String cardNumber = '';
  String? cardSystem = '';
  String expiryDate = '';
  String cvv = '';
  void setCardNumber({required String numberOfCard}) {
    cardNumber = numberOfCard;
    notifyListeners();
  }

  void setCardSystem({String? cardName, String? expiryDate, String? cvv}) {
    cardSystem = getCardSystemData(cardNumber)?.system ?? 'Mastercard';
    this.expiryDate = expiryDate ?? this.expiryDate;
    this.cvv = cvv ?? this.cvv;
    this.cardName = cardName ?? this.cardName;
    notifyListeners();
  }

  //user data
  String userName = '';
  String userEmail = '';
  String userImage = '';
  String userID = '';

  void setUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userName = pref.getString('userFullName') ?? 'full Name';
    userEmail = pref.getString('userEmail') ?? 'email';
    userImage = pref.getString('userImage') ?? '';
    userID = pref.getString('userID') ?? 'userID';
    notifyListeners();
  }

  Future<sql.Database> init() async {
    return await sql.openDatabase('productsCartItems.db', version: 1,
        onCreate: (cart, version) async {
      await cart
          .execute(
              'CREATE TABLE productsCartItems(id INTEGER PRIMARY KEY, pro_id TEXT, pro_name TEXT, pro_desc TEXT,pro_subname TEXT, type TEXT, cat_id TEXT, pro_img TEXT, pro_price TEXT, pro_count INTEGER)')
          .then((value) => null)
          .catchError((error) {});
    }, onOpen: (cart) async {
      await cart.rawQuery('SELECT * FROM productsCartItems');
    });
  }

  void getCount({required ProductModel productData}) {
    getCart();
    List<String> list = [];
    for (int i = 0; i < cartList.length; i++) {
      list.add(cartList[i].productID);
    }
    int index = list.indexOf(productData.productID);
    count = (index == -1) ? 0 : cartList[index].count;

    notifyListeners();
  }

  void incrementCount() {
    count = count! + 1;
    notifyListeners();
  }

  void decrementCount() {
    if (count! > 1) {
      count = count! - 1;
    }
    notifyListeners();
  }

// cart functionality

  void calculateTotal() async {
    final sql.Database products = await init();
    await products
        .rawQuery('SELECT * FROM productsCartItems')
        .then((value) async {
      total = 0;
      for (int i = 0; i < value.length; i++) {
        Map product = value[i];
        int productPrice = int.parse(product["pro_price"]);
        int productCount = product["pro_count"];
        total = total + (productPrice * productCount);
      }
    }).catchError((error) {});
    notifyListeners();
  }

  void getCart() async {
    final sql.Database products = await init();
    await products
        .rawQuery('SELECT * FROM productsCartItems')
        .then((value) async {
      cartList = [];
      List cartProductsIDsList = [];
      for (int i = 0; i < value.length; i++) {
        Map product = value[i];
        cartList.add(ProductModel(
          productID: product["pro_id"],
          productName: product["pro_name"],
          productDescription: product["pro_desc"],
          productSubname: product["pro_subname"],
          productType: product["type"],
          categoryID: product["cat_id"],
          productImage: product["pro_img"],
          productPrice: product["pro_price"],
          count: product["pro_count"],
        ));
        cartProductsIDsList.add(product["pro_id"]);
      }
      cartProductsIDs = cartProductsIDsList.toString();
    }).catchError((error) {});

    notifyListeners();
  }

  void deleteCartProduct({required ProductModel product}) async {
    final sql.Database products = await init();
    await products
        .rawQuery(
            'DELETE FROM productsCartItems WHERE pro_id = "${product.productID}" AND pro_name = "${product.productName}" AND pro_desc = "${product.productDescription}" AND pro_subname = "${product.productSubname}" AND type = "${product.productType}" AND cat_id = "${product.categoryID}" AND pro_img = "${product.productImage}" AND pro_price = "${product.productPrice}"')
        .then((value) => null)
        .catchError((error) {});
    notifyListeners();
  }

  void deleteAllCartProducts() async {
    final sql.Database products = await init();
    await products
        .rawQuery('DELETE FROM productsCartItems')
        .then((value) => null)
        .catchError((error) {});
    getCart();
    calculateTotal();
    notifyListeners();
  }

  void incrementCartCount({required ProductModel product}) async {
    final sql.Database products = await init();
    await products
        .rawQuery(
            'SELECT * FROM productsCartItems WHERE pro_id = "${product.productID}" AND pro_name = "${product.productName}" AND pro_desc = "${product.productDescription}" AND pro_subname = "${product.productSubname}" AND type = "${product.productType}" AND cat_id = "${product.categoryID}" AND pro_img = "${product.productImage}" AND pro_price = "${product.productPrice}"')
        .then((value) {
      Object? countObject = value[0]["pro_count"];
      int count = int.parse(countObject.toString());
      products.rawQuery(
          'UPDATE productsCartItems SET pro_count = ${count + 1} WHERE pro_id = "${product.productID}" AND pro_name = "${product.productName}" AND pro_desc = "${product.productDescription}" AND pro_subname = "${product.productSubname}" AND type = "${product.productType}" AND cat_id = "${product.categoryID}" AND pro_img = "${product.productImage}" AND pro_price = "${product.productPrice}"');
      getCart();
      calculateTotal();
    }).catchError((error) {});
    notifyListeners();
  }

  void decrementCartCount({required ProductModel product}) async {
    final sql.Database products = await init();
    await products
        .rawQuery(
            'SELECT * FROM productsCartItems WHERE pro_id = "${product.productID}" AND pro_name = "${product.productName}" AND pro_desc = "${product.productDescription}" AND pro_subname = "${product.productSubname}" AND type = "${product.productType}" AND cat_id = "${product.categoryID}" AND pro_img = "${product.productImage}" AND pro_price = "${product.productPrice}"')
        .then((value) {
      Object? countObject = value[0]["pro_count"];
      int count = int.parse(countObject.toString());
      if (count > 1) {
        products.rawQuery(
            'UPDATE productsCartItems SET pro_count = ${count - 1} WHERE pro_id = "${product.productID}" AND pro_name = "${product.productName}" AND pro_desc = "${product.productDescription}" AND pro_subname = "${product.productSubname}" AND type = "${product.productType}" AND cat_id = "${product.categoryID}" AND pro_img = "${product.productImage}" AND pro_price = "${product.productPrice}"');
        getCart();
        calculateTotal();
      }
    }).catchError((error) {});
    notifyListeners();
  }

  Future insertProduct({required ProductModel productData}) async {
    final sql.Database products = await init();
    //get the data of the same type
    List data;
    data = await products.rawQuery(
        'SELECT * FROM productsCartItems WHERE pro_name = "${productData.productName}" AND pro_id = "${productData.productID}" AND pro_desc = "${productData.productDescription}" ');
    if (data.isNotEmpty) {
      incrementCartCount(product: productData);
    } else {
      await products.transaction((txn) async {
        await txn
            .rawInsert(
                'INSERT INTO productsCartItems(pro_id, pro_name, pro_desc, pro_subname, type, cat_id, pro_img, pro_price, pro_count) VALUES("${productData.productID}", "${productData.productName}", "${productData.productDescription}", "${productData.productSubname}","${productData.productType}", "${productData.categoryID}", "${productData.productImage}", "${productData.productPrice}", 1 )')
            .then((value) {
          return null;
        }).catchError((error) {});

        getCart();
        notifyListeners();
      });
    }
    calculateTotal();
    checkAdded(productData: productData);
  }

  // favourites

  List<ProductModel> wishList = [];
  Future<sql.Database> favouritesInit() async {
    return await sql.openDatabase('favourites.db', version: 1,
        onCreate: (cart, version) async {
      await cart
          .execute(
              'CREATE TABLE favourites(id INTEGER PRIMARY KEY, pro_id TEXT, pro_name TEXT, pro_desc TEXT,pro_subname TEXT, type TEXT, cat_id TEXT, pro_img TEXT, pro_price TEXT)')
          .then((value) => null)
          .catchError((error) {});
    });
  }

  void checkAdded({required ProductModel productData}) {
    List<String> list = [];
    if (cartList.isNotEmpty) {
      for (int i = 0; i < cartList.length; i++) {
        list.add(cartList[i].productID);
      }
    }
    isAdded = list.contains(productData.productID);
    notifyListeners();
  }

  void addToFavourite({required ProductModel productData}) async {
    final sql.Database favourites = await favouritesInit();
    //get the data of the same type
    List data;
    data = await favourites.rawQuery(
        'SELECT * FROM favourites WHERE pro_id = "${productData.productID}"');
    if (data.isNotEmpty) {
      null;
    } else {
      await favourites.transaction((txn) async {
        await txn
            .rawInsert(
                'INSERT INTO favourites(pro_id, pro_name, pro_desc, pro_subname, type, cat_id, pro_img, pro_price) VALUES("${productData.productID}", "${productData.productName}", "${productData.productDescription}", "${productData.productSubname}","${productData.productType}", "${productData.categoryID}", "${productData.productImage}", "${productData.productPrice}")')
            .then((value) {
          return null;
        }).catchError((error) {});
      });
      isFavourite = true;
      checkFavourites(productData: productData);
    }
    getFavourites();

    notifyListeners();
  }

  void checkFavourites({required ProductModel productData}) async {
    sql.Database favourites = await favouritesInit();
    List data;
    data = await favourites.rawQuery(
        'SELECT * FROM favourites WHERE pro_name = "${productData.productName}" AND pro_id = "${productData.productID}" AND pro_desc = "${productData.productDescription}"');
    if (data.isNotEmpty) {
      isFavourite = true;
    } else {
      isFavourite = false;
    }
    getFavourites();
    notifyListeners();
  }

  void deleteFromFavourite({required ProductModel productData}) async {
    sql.Database favourites = await favouritesInit();
    await favourites.rawQuery(
        'DELETE FROM favourites WHERE pro_id = "${productData.productID}"');
    isFavourite = false;
    checkFavourites(productData: productData);
    getFavourites();
    notifyListeners();
  }

  void getFavourites() async {
    final sql.Database favourites = await favouritesInit();
    List data = await favourites.rawQuery('SELECT * FROM favourites');
    wishList = [];
    for (int i = 0; i < data.length; i++) {
      wishList.add(ProductModel.fromJson(data[i]));
    }
    notifyListeners();
  }

  void deleteFavourites() async {
    sql.Database favourites = await favouritesInit();
    favourites.execute('DELETE FROM favourites');
    getFavourites();
    notifyListeners();
  }

  // Credit Cards
  List<CardModel> creditCardsList = [];
  Future<sql.Database> creditCardsInit() async {
    return await sql.openDatabase('cards.db', version: 1,
        onCreate: (cards, version) async {
      await cards
          .execute(
              'CREATE TABLE Cards (id INTEGER PRIMARY KEY, cardHolderName TEXT, cardNumber TEXT, cardExpiryDate TEXT, cardCVV TEXT, cardType TEXT)')
          .then((value) {})
          .catchError((error) {});
    }, onOpen: (cards) async {});
  }

  void getCards() async {
    final sql.Database cards = await creditCardsInit();
    List data = await cards.rawQuery('SELECT * FROM Cards');
    creditCardsList = [];
    for (int i = 0; i < data.length; i++) {
      creditCardsList.add(CardModel.fromData(data[i]));
    }
    notifyListeners();
  }

  void addToCreditCards({required CardModel cardData}) async {
    final sql.Database cards = await creditCardsInit();
    //get the data of the same type
    List data;
    data = await cards.rawQuery(
        'SELECT * FROM Cards WHERE cardNumber = "${cardData.cardNumber}"');
    if (data.isNotEmpty) {
      null;
    } else {
      await cards.transaction((txn) async {
        await txn
            .rawInsert(
                'INSERT INTO Cards(cardHolderName, cardNumber, cardExpiryDate, cardCVV, cardType) VALUES("${cardData.cardHolderName}", "${cardData.cardNumber}", "${cardData.cardExpiryDate}", "${cardData.cardCVV}","${cardData.cardType}")')
            .then((value) {
          return null;
        }).catchError((error) {});
      });
    }
    getCards();
    notifyListeners();
  }

  void updateCard(
      {required CardModel card, required String oldCardNumber}) async {
    final sql.Database cards = await creditCardsInit();
    cards.rawQuery(
        'UPDATE Cards SET cardHolderName = "${card.cardHolderName}", cardNumber = "${card.cardNumber}", cardExpiryDate = "${card.cardExpiryDate}", cardCVV = "${card.cardCVV}", cardType = "${card.cardType}" WHERE cardNumber = "$oldCardNumber"');
    notifyListeners();
  }

  //user orders history
  List<UserOrdersModel> userOrdersHistory = [];
  void getAllUserOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getString('userID') ?? '';
    userOrdersHistory =
        await GetOrdersHistoryService().getOrderHistory(userID: userID);
    notifyListeners();
  }

  List<String> productsImages = [];
  List<String> productsIDs = [];
  void getUserOrdersImages() async {
    List<dynamic> data = await ApiHelper().get(ApiUrl.bestSelling);
    List<ProductModel> bestSellingProducts = [];
    for (int i = 0; i < data.length; i++) {
      bestSellingProducts.add(ProductModel.fromJson(data[i]));
      productsIDs.add(ProductModel.fromJson(data[i]).productID);
      productsImages.add(ProductModel.fromJson(data[i]).productImage);
    }
  }
}
