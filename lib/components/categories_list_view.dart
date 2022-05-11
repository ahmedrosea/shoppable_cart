import 'package:flutter/material.dart';
import 'package:shoppablecard/api.dart';
import 'package:shoppablecard/components/categories_list_view_item.dart';
import 'package:shoppablecard/helper/api_helper.dart';
import 'package:shoppablecard/models/category_model.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({Key? key}) : super(key: key);

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  List<dynamic> data = [];

  Future<List<CategoryModel>> getCategories() async {
    data = await ApiHelper().get(ApiUrl.allCategories);
    List<CategoryModel> categoriesList = [];
    for (int i = 0; i < data.length; i++) {
      categoriesList.add(CategoryModel.fromJson(data[i]));
    }
    return categoriesList;
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      child: FutureBuilder<List<CategoryModel>>(
          future: getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CategoryModel>? data = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) {
                  return CategoriesListViewItem(
                    itemImage: data![index].categoryImage,
                    itemTitle: data[index].categoryTitle,
                    categoryData: data[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 20.0,
                  );
                },
                itemCount: data!.length,
                scrollDirection: Axis.horizontal,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Text('');
          }),
    );
  }
}
