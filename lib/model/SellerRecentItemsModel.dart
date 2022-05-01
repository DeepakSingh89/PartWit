import 'dart:convert';

SellerRecentItemsModel sellerRecentItemsModelFromJson(String str) => SellerRecentItemsModel.fromJson(json.decode(str));

String sellerRecentItemsModelToJson(SellerRecentItemsModel data) => json.encode(data.toJson());

class SellerRecentItemsModel {
  SellerRecentItemsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory SellerRecentItemsModel.fromJson(Map<String, dynamic> json) => SellerRecentItemsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.products,
  });

  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.featuredImage,
    this.date,
  });

  int? id;
  String? name;
  int? price;
  String? featuredImage;
  String? date;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    featuredImage: json["featured_image"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "featured_image": featuredImage,
    "date": date,
  };
}
