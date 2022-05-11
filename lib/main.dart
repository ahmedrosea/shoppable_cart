import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppablecard/screens/home_screen.dart';
import 'package:shoppablecard/screens/splash_screen.dart';
import 'state_management/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: ShoppableCart(
      isLoggedIn: sharedPreference.getBool('isLoggedIn'),
    ),
  ));
}

class ShoppableCart extends StatefulWidget {
  const ShoppableCart({Key? key, required this.isLoggedIn}) : super(key: key);

  final bool? isLoggedIn;

  @override
  State<ShoppableCart> createState() => _ShoppableCartState();
}

class _ShoppableCartState extends State<ShoppableCart> {
  @override
  void initState() {
    context.read<MyProvider>().getCart();
    context.read<MyProvider>().calculateTotal();
    context.read<MyProvider>().creditCardsInit();
    context.read<MyProvider>().getFavourites();
    context.read<MyProvider>().getCards();
    context.read<MyProvider>().getAllUserOrders();
    context.read<MyProvider>().getUserOrdersImages();
    // context.read<MyProvider>().getCartProductsIDs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          widget.isLoggedIn == true ? const HomeScreen() : const SplashScreen(),
      /*widget.isLoggedIn == true ? const HomeScreen() : const SplashScreen()*/
      /*ViewOrder(statueOfOrder: 'Out for delivery',)*/
    );
  }
}
