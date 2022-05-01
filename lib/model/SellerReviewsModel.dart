import 'dart:convert';

SellerReviewsModel sellerReviewsModelFromJson(String str) => SellerReviewsModel.fromJson(json.decode(str));

String sellerReviewsModelToJson(SellerReviewsModel data) => json.encode(data.toJson());

class SellerReviewsModel {
  SellerReviewsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory SellerReviewsModel.fromJson(Map<String, dynamic> json) => SellerReviewsModel(
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
    this.sellerId,
    this.userId,
    this.stars,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.sellerName,
    this.userName,
    this.userProfilePic,
  });

  int? id;
  int? sellerId;
  int? userId;
  double? stars;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? sellerName;
  String? userName;
  String? userProfilePic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sellerId: json["seller_id"],
    userId: json["user_id"],
    stars: json["stars"].toDouble(),
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    sellerName: json["seller_name"],
    userName: json["user_name"],
    userProfilePic: json["user_profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seller_id": sellerId,
    "user_id": userId,
    "stars": stars,
    "description": description,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "seller_name": sellerName,
    "user_name": userName,
    "user_profile_pic": userProfilePic,
  };
}
