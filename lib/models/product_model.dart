
class ProductModel{
  final String productID;
  final String productName;
  final String productDescription;
  final String productSubname;
  final String productType;
  final String categoryID;
  final String productImage;
  final String productPrice;
  int? count;

  ProductModel({
    required this.productID,
    required this.productName, 
    required this.productDescription, 
    required this.productSubname, 
    required this.productType, 
    required this.categoryID, 
    required this.productImage, 
    required this.productPrice,
    this.count
    });

  factory ProductModel.fromJson(jsonData){
    return ProductModel(
      productID: jsonData["pro_id"], 
      productName: jsonData["pro_name"], 
      productDescription: jsonData["pro_desc"], 
      productSubname: jsonData["pro_subname"], 
      productType: jsonData["type"], 
      categoryID: jsonData["cat_id"], 
      productImage: jsonData["pro_img"], 
      productPrice: jsonData["pro_price"]
      );
  }
}