
import 'dart:convert';

CateListListedForSaleModel cateListListedForSaleModelFromJson(String str) => CateListListedForSaleModel.fromJson(json.decode(str));

String cateListListedForSaleModelToJson(CateListListedForSaleModel data) => json.encode(data.toJson());

class CateListListedForSaleModel {
  CateListListedForSaleModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory CateListListedForSaleModel.fromJson(Map<String, dynamic> json) => CateListListedForSaleModel(
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
    this.parentId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? parentId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    parentId: json["parent_id"],
    title: json["title"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "title": title,
    "description": description,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
