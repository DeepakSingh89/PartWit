// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
    this.notifications,
  });

  List<Notification>? notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    this.id,
    this.type,
    this.title,
    this.description,
    this.meta,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? title;
  String? description;
  Meta? meta;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    type: json["type"],
    title: json["title"],
    description: json["description"],
    meta: Meta.fromJson(json["meta"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": title,
    "description": description,
    "meta": meta!.toJson(),
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Meta {
  Meta({
    this.customerId,
    this.customerName,
  });

  int? customerId;
  String? customerName;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    customerId: json["customer_id"],
    customerName: json["customer_name"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "customer_name": customerName,
  };
}
