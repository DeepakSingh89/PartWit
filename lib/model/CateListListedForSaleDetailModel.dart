
import 'dart:convert';

CateListListedForSaleDetailModel cateListListedForSaleDetailModelFromJson(String str) => CateListListedForSaleDetailModel.fromJson(json.decode(str));

String cateListListedForSaleDetailModelToJson(CateListListedForSaleDetailModel data) => json.encode(data.toJson());

class CateListListedForSaleDetailModel {
  CateListListedForSaleDetailModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory CateListListedForSaleDetailModel.fromJson(Map<String, dynamic> json) => CateListListedForSaleDetailModel(
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
    this.viewCount,
  });

  int? id;
  String? name;
  int? price;
  String? featuredImage;
  String? date;
  int? viewCount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    featuredImage: json["featured_image"],
    date: json["date"],
    viewCount: json["view_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "featured_image": featuredImage,
    "date": date,
    "view_count": viewCount,
  };
}
