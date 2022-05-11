import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/bottom_nav_bar.dart';
import 'package:shoppablecard/state_management/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MyProvider>().setUserData();
    return const Scaffold(
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
