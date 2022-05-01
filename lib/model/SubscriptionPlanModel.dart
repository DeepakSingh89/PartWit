// To parse this JSON data, do
//
//     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) => SubscriptionPlanModel.fromJson(json.decode(str));

String subscriptionPlanModelToJson(SubscriptionPlanModel data) => json.encode(data.toJson());

class SubscriptionPlanModel {
  SubscriptionPlanModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
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
    this.title,
    this.description,
    this.price,
    this.productLimit,
    this.type,
    this.number,
    this.subscriptionType,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? title;
  String? description;
  String? price;
  int? productLimit;
  String? type;
  int? number;
  String? subscriptionType;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    productLimit: json["product_limit"],
    type: json["type"],
    number: json["number"],
    subscriptionType: json["subscription_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "product_limit": productLimit,
    "type": type,
    "number": number,
    "subscription_type": subscriptionType,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
