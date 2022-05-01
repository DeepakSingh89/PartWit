import 'dart:convert';

TermAndConditionModel termAndConditionModelFromJson(String str) => TermAndConditionModel.fromJson(json.decode(str));

String termAndConditionModelToJson(TermAndConditionModel data) => json.encode(data.toJson());

class TermAndConditionModel {
  TermAndConditionModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory TermAndConditionModel.fromJson(Map<String, dynamic> json) => TermAndConditionModel(
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
    this.title,
    this.shortDescription,
    this.description,
    this.status,
    this.userId,
    this.parrentId,
    this.type,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? title;
  dynamic shortDescription;
  String? description;
  String? status;
  int? userId;
  int? parrentId;
  String? type;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    shortDescription: json["short_description"],
    description: json["description"],
    status: json["status"],
    userId: json["user_id"],
    parrentId: json["parrent_id"],
    type: json["type"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "short_description": shortDescription,
    "description": description,
    "status": status,
    "user_id": userId,
    "parrent_id": parrentId,
    "type": type,
    "slug": slug,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
