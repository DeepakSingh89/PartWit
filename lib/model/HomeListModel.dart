import 'dart:convert';

HomeListModel homeListModelFromJson(String str) => HomeListModel.fromJson(json.decode(str));

String homeListModelToJson(HomeListModel data) => json.encode(data.toJson());

class HomeListModel {
  HomeListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory HomeListModel.fromJson(Map<String, dynamic> json) => HomeListModel(
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
    this.catId,
    this.title,
    this.products,
  });

  int? catId;
  String? title;
  List<Product>? products;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    catId: json["cat_id"],
    title: json["title"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "title": title,
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
