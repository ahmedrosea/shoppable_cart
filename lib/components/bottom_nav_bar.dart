import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shoppablecard/screens/explore_screen.dart';
import 'package:shoppablecard/screens/profile_screen.dart';
import 'package:shoppablecard/screens/shopping_cart_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  int currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(),
    const ShoppingCartScreen(),
    const ProfileScreen(),
  ];
  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
        title: ('Explore'),
        icon: const Center(
            child: Text(
          'Explore',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        )),
        inactiveIcon: Image.asset(
          'assets/images/explore_icon.png',
        ),
        activeColorPrimary: Colors.black),
    PersistentBottomNavBarItem(
        title: (''),
        icon: const Center(
            child: Text(
          'Cart',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        )),
        inactiveIcon: Image.asset(
          'assets/images/cart_icon.png',
        ),
        activeColorPrimary: Colors.black),
    PersistentBottomNavBarItem(
        title: (''),
        icon: const Center(
            child: Text(
          'Account',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        )),
        inactiveIcon: Image.asset(
          'assets/images/user_icon.png',
        ),
        activeColorPrimary: Colors.black)
  ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller, screens: _screens,
      items: _navBarItems,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      onItemSelected: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      navBarHeight: 80.0,
      navBarStyle: NavBarStyle.style12,
    );
  }
}
