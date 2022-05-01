
import 'dart:convert';

SavedItemsModel savedItemsModelFromJson(String str) => SavedItemsModel.fromJson(json.decode(str));

String savedItemsModelToJson(SavedItemsModel data) => json.encode(data.toJson());

class SavedItemsModel {
  SavedItemsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory SavedItemsModel.fromJson(Map<String, dynamic> json) => SavedItemsModel(
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
    this.productId,
    this.userId,
    this.productName,
    this.price,
    this.date,
    this.featuredImage,
  });

  int? id;
  int? productId;
  int? userId;
  String? productName;
  int? price;
  DateTime? date;
  dynamic featuredImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    productName: json["product_name"],
    price: json["price"],
    date: DateTime.parse(json["date"]),
    featuredImage: json["featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "product_name": productName,
    "price": price,
    "date": date!.toIso8601String(),
    "featured_image": featuredImage,
  };
}

class FeaturedImageClass {
  FeaturedImageClass();

  factory FeaturedImageClass.fromJson(Map<String, dynamic> json) => FeaturedImageClass(
  );

  Map<String, dynamic> toJson() => {
  };
}
