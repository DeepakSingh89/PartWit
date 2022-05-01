// To parse this JSON data, do
//
//     final singleShowProductModel = singleShowProductModelFromJson(jsonString);

import 'dart:convert';

SingleShowProductModel singleShowProductModelFromJson(String str) => SingleShowProductModel.fromJson(json.decode(str));

String singleShowProductModelToJson(SingleShowProductModel data) => json.encode(data.toJson());

class SingleShowProductModel {
  SingleShowProductModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory SingleShowProductModel.fromJson(Map<String, dynamic> json) => SingleShowProductModel(
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
    this.id,
    this.name,
    this.sellerId,
    this.shortDesc,
    this.description,
    this.price,
    this.categoryId,
    this.listedOn,
    this.expiresOn,
    this.featuredImage,
    this.allImages,
    this.createdAt,
    this.updatedAt,
    this.serllerInfo,
  });

  int? id;
  String? name;
  int? sellerId;
  String? shortDesc;
  String? description;
  int? price;
  int? categoryId;
  String? listedOn;
  String? expiresOn;
  String? featuredImage;
  List<String>? allImages;
  DateTime? createdAt;
  DateTime? updatedAt;
  SerllerInfo? serllerInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    sellerId: json["seller_id"],
    shortDesc: json["short_desc"],
    description: json["description"],
    price: json["price"],
    categoryId: json["category_id"],
    listedOn: json["listed_on"],
    expiresOn: json["expires_on"],
    featuredImage: json["featured_image"],
    allImages: List<String>.from(json["all_images"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    serllerInfo: SerllerInfo.fromJson(json["serller_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seller_id": sellerId,
    "short_desc": shortDesc,
    "description": description,
    "price": price,
    "category_id": categoryId,
    "listed_on": listedOn,
    "expires_on": expiresOn,
    "featured_image": featuredImage,
    "all_images": List<dynamic>.from(allImages!.map((x) => x)),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "serller_info": serllerInfo!.toJson(),
  };
}

class SerllerInfo {
  SerllerInfo({
    this.id,
    this.name,
    this.profilePic,
    this.rating,
  });

  int? id;
  String? name;
  String? profilePic;
  double? rating;

  factory SerllerInfo.fromJson(Map<String, dynamic> json) => SerllerInfo(
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
