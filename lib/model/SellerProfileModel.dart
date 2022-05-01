// To parse this JSON data, do
//
//     final sellerProfileModel = sellerProfileModelFromJson(jsonString);

import 'dart:convert';

SellerProfileModel sellerProfileModelFromJson(String str) => SellerProfileModel.fromJson(json.decode(str));

String sellerProfileModelToJson(SellerProfileModel data) => json.encode(data.toJson());

class SellerProfileModel {
  SellerProfileModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory SellerProfileModel.fromJson(Map<String, dynamic> json) => SellerProfileModel(
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
    this.seller,
    this.products,
  });

  Seller? seller;
  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    seller: Seller.fromJson(json["seller"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seller": seller!.toJson(),
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

class Seller {
  Seller({
    this.id,
    this.name,
    this.profilePic,
    this.rating,
  });

  int? id;
  String? name;
  String? profilePic;
  double? rating;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_pic": profilePic,
    "rating": rating,
  };
}
