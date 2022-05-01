

import 'dart:convert';

AttributesModel attributesModelFromJson(String str) => AttributesModel.fromJson(json.decode(str));

String attributesModelToJson(AttributesModel data) => json.encode(data.toJson());

class AttributesModel {
  AttributesModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Data>? data;

  factory AttributesModel.fromJson(Map<String, dynamic> json) => AttributesModel(
    status: json["status"],
    message: json["message"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.catId,
    this.title,
    this.colour,
    this.color,
    this.colors,
    this.type,
    this.brand,
    this.model,
    this.modal,
    this.operatingSystem,
    this.internalMemory,
    this.resolution,
  });

  int? id;
  int? catId;
  String? title;
  List<Brand>? colour;
  List<Brand>? color;
  List<Brand>? colors;
  List<Brand>? type;
  List<Brand>? brand;
  List<Brand>? model;
  List<Brand>? modal;
  List<Brand>? operatingSystem;
  List<Brand>? internalMemory;
  List<Brand>? resolution;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    catId: json["cat_id"],
    title: json["title"],
    colour: json["Colour"] == null ? null : List<Brand>.from(json["Colour"].map((x) => Brand.fromJson(x))),
    color: json["Color"] == null ? null : List<Brand>.from(json["Color"].map((x) => Brand.fromJson(x))),
    colors: json["Colors"] == null ? null : List<Brand>.from(json["Colors"].map((x) => Brand.fromJson(x))),
    type: json["Type"] == null ? null : List<Brand>.from(json["Type"].map((x) => Brand.fromJson(x))),
    brand: json["Brand"] == null ? null : List<Brand>.from(json["Brand"].map((x) => Brand.fromJson(x))),
    model: json["Model"] == null ? null : List<Brand>.from(json["Model"].map((x) => Brand.fromJson(x))),
    modal: json["Modal"] == null ? null : List<Brand>.from(json["Modal"].map((x) => Brand.fromJson(x))),
    operatingSystem: json["Operating System"] == null ? null : List<Brand>.from(json["Operating System"].map((x) => Brand.fromJson(x))),
    internalMemory: json["Internal Memory"] == null ? null : List<Brand>.from(json["Internal Memory"].map((x) => Brand.fromJson(x))),
    resolution: json["Resolution"] == null ? null : List<Brand>.from(json["Resolution"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "title": title,
    "Colour": colour == null ? null : List<dynamic>.from(colour!.map((x) => x.toJson())),
    "Color": color == null ? null : List<dynamic>.from(color!.map((x) => x.toJson())),
    "Colors": colors == null ? null : List<dynamic>.from(colors!.map((x) => x.toJson())),
    "Type": type == null ? null : List<dynamic>.from(type!.map((x) => x.toJson())),
    "Brand": brand == null ? null : List<dynamic>.from(brand!.map((x) => x.toJson())),
    "Model": model == null ? null : List<dynamic>.from(model!.map((x) => x.toJson())),
    "Modal": model == null ? null : List<dynamic>.from(model!.map((x) => x.toJson())),
    "Operating System": operatingSystem == null ? null : List<dynamic>.from(operatingSystem!.map((x) => x.toJson())),
    "Internal Memory": internalMemory == null ? null : List<dynamic>.from(internalMemory!.map((x) => x.toJson())),
    "Resolution": resolution == null ? null : List<dynamic>.from(resolution!.map((x) => x.toJson())),
  };
}

class Brand {
  Brand({
    this.id,
    this.attrId,
    this.catId,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? attrId;
  int? catId;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    attrId: json["attr_id"],
    catId: json["cat_id"],
    title: json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attr_id": attrId,
    "cat_id": catId,
    "title": title,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
