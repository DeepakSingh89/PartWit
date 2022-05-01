// To parse this JSON data, do
//
//     final reasonsModel = reasonsModelFromJson(jsonString);

import 'dart:convert';

ReasonsModel reasonsModelFromJson(String str) => ReasonsModel.fromJson(json.decode(str));

String reasonsModelToJson(ReasonsModel data) => json.encode(data.toJson());

class ReasonsModel {
  ReasonsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory ReasonsModel.fromJson(Map<String, dynamic> json) => ReasonsModel(
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
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
