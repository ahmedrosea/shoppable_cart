
class CategoryModel{
  final String categoryId;
  final String categoryImage;
  final String categoryTitle;
  CategoryModel({required this.categoryId,required this.categoryImage, required this.categoryTitle});

  factory CategoryModel.fromJson(jsonData){
    return CategoryModel(categoryId: jsonData["cat_id"], categoryImage: jsonData["cat_icon"], categoryTitle: jsonData["cat_name"]);
  }
}