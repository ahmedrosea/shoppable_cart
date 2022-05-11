import 'package:flutter/material.dart';
import 'package:shoppablecard/components/best_selling_section.dart';
import '../components/categories_section.dart';
import '../components/search_field.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Map> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.all(20.0), child: SearchField()),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                child: Column(
                  children: const [
                    CategoriesSection(),
                    SizedBox(
                      height: 20.0,
                    ),
                    BestSellingSection(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
