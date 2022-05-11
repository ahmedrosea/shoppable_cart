import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/helper/shared_preferences_helper.dart';
import 'package:shoppablecard/screens/Account%20_Track_Order/track_order.dart';
import 'package:shoppablecard/screens/account_payments/cards_screen.dart';
import 'package:shoppablecard/screens/account_wish_list/account_wish_list.dart';
import 'package:shoppablecard/screens/login_screen.dart';
import '../components/custom_listAccount.dart';
import '../components/custom_logoAccount.dart';
import '../state_management/provider.dart';
import 'account_shipping_address/account_shipping_address.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? profileName = context.watch<MyProvider>().userName;
    String? profileEmail = context.watch<MyProvider>().userEmail;
    String? profileImage = context.watch<MyProvider>().userImage;
    return Scaffold(
        body: Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 70, left: 17, right: 17.0),
      child: ListView(children: [
        SizedBox(
            child: Column(
          children: [
            CustomLogoAccount(
              imagePerson: profileImage,
              emailPerson: profileEmail,
              namePerson: profileName,
            ),
            const SizedBox(
              height: 70,
            ),
            const customListAccount(
                title_name: "Edit Profile",
                iconLeft: 'assets/images/a1.png',
                iconRight: 'assets/images/a8.png'),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountShipping()));
              },
              child: const customListAccount(
                  title_name: "Shipping Address",
                  iconLeft: 'assets/images/a2.png',
                  iconRight: 'assets/images/a8.png'),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WishlistScreen()));
          },
          child: const customListAccount(
              title_name: "Wishlist",
              iconLeft: 'assets/images/a3.png',
              iconRight: 'assets/images/a8.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TrackOrder()));
          },
          child: const customListAccount(
              title_name: "Order History",
              iconLeft: 'assets/images/a4.png',
              iconRight: 'assets/images/a8.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CardsScreen()));
          },
          child: const customListAccount(
              title_name: "Cards",
              iconLeft: 'assets/images/a5.png',
              iconRight: 'assets/images/a8.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        const customListAccount(
            title_name: "Notifications",
            iconLeft: 'assets/images/a6.png',
            iconRight: 'assets/images/a8.png'),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            setState(() {
              SharedPreferencesHelper().putBool(key: 'isLoggedIn', data: false);
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginScreen();
                  },
                ),
                (_) => false,
              );
            });
          },
          child: const customListAccount(
              title_name: "Log Out",
              iconLeft: 'assets/images/a7.png',
              iconRight: 'assets/images/a8.png'),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    ));
  }
}
