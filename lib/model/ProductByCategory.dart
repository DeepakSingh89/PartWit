// To parse this JSON data, do
//
//     final productByCategory = productByCategoryFromJson(jsonString);

import 'dart:convert';

ProductByCategory productByCategoryFromJson(String str) => ProductByCategory.fromJson(json.decode(str));

String productByCategoryToJson(ProductByCategory data) => json.encode(data.toJson());

class ProductByCategory {
  ProductByCategory({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory ProductByCategory.fromJson(Map<String, dynamic> json) => ProductByCategory(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
