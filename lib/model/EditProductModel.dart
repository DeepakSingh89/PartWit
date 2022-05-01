// To parse this JSON data, do
//
//     final editProductModel = editProductModelFromJson(jsonString);

import 'dart:convert';

EditProductModel editProductModelFromJson(String str) => EditProductModel.fromJson(json.decode(str));

String editProductModelToJson(EditProductModel data) => json.encode(data.toJson());

class EditProductModel {
  EditProductModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory EditProductModel.fromJson(Map<String, dynamic> json) => EditProductModel(
    status: json["status"] ,
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
    this.viewCount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.seller,
    this.categories,
    this.productAttributes,
    this.attributes,
  });

  int? id;
  String? name;
  int? sellerId;
  String? shortDesc;
  String? description;
  int? price;
  int? categoryId;
  DateTime? listedOn;
  DateTime? expiresOn;
  String? featuredImage;
  List<String>? allImages;
  int? viewCount;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Seller? seller;
  List<Category>? categories;
  List<ProductAttribute>? productAttributes;
  List<Attribute>? attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"]== null ? null : json["name"],
    sellerId: json["seller_id"]== null ? null : json["seller_id"],
    shortDesc: json["short_desc"]== null ? null : json["short_desc"],
    description: json["description"]== null ? null : json["description"],
    price: json["price"]== null ? null : json["price"],
    categoryId: json["category_id"]== null ? null : json["category_id"],
    listedOn: DateTime.parse(json["listed_on"]),
    expiresOn: DateTime.parse(json["expires_on"]),
    featuredImage: json["featured_image"] == null ? null : json["featured_image"],
    allImages: List<String>.from(json["all_images"].map((x) => x)),
    viewCount: json["view_count"],
    status: json["status"]  == null ? null : json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    seller: Seller.fromJson(json["seller"]),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    productAttributes: List<ProductAttribute>.from(json["product_attributes"].map((x) => ProductAttribute.fromJson(x))),
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seller_id": sellerId,
    "short_desc": shortDesc,
    "description": description,
    "price": price,
    "category_id": categoryId,
    "listed_on": listedOn!.toIso8601String(),
    "expires_on": expiresOn!.toIso8601String(),
    "featured_image": featuredImage,
    "all_images": List<dynamic>.from(allImages!.map((x) => x)),
    "view_count": viewCount,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "seller": seller!.toJson(),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "product_attributes": List<dynamic>.from(productAttributes!.map((x) => x.toJson())),
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    this.id,
    this.catId,
    this.title,
    this.selected,
    this.colour,
    this.brand,
    this.model,
    this.operatingSystem,
    this.internalMemory,
    this.resolution,
  });

  int? id;
  int? catId;
  String? title;
  bool? selected;
  List<AttributeBrand>? colour;
  List<AttributeBrand>? brand;
  List<AttributeBrand>? model;
  List<AttributeBrand>? operatingSystem;
  List<AttributeBrand>? internalMemory;
  List<AttributeBrand>? resolution;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"]  == null ? null : json["id"],
    catId: json["cat_id"] == null ? null : json["cat_id"],
    title: json["title"] == null ? null : json["title"],
    selected: json["selected"] == null ? null : json["selected"],
    colour: json["Colour"] == null ? null : List<AttributeBrand>.from(json["Colour"].map((x) => AttributeBrand.fromJson(x))),
    brand: json["Brand"] == null ? null : List<AttributeBrand>.from(json["Brand"].map((x) => AttributeBrand.fromJson(x))),
    model: json["Model"] == null ? null : List<AttributeBrand>.from(json["Model"].map((x) => AttributeBrand.fromJson(x))),
    operatingSystem: json["Operating System"] == null ? null : List<AttributeBrand>.from(json["Operating System"].map((x) => AttributeBrand.fromJson(x))),
    internalMemory: json["Internal Memory"] == null ? null : List<AttributeBrand>.from(json["Internal Memory"].map((x) => AttributeBrand.fromJson(x))),
    resolution: json["Resolution"] == null ? null : List<AttributeBrand>.from(json["Resolution"].map((x) => AttributeBrand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_id": catId,
    "title": title,
    "selected": selected,
    "Colour": colour == null ? null : List<dynamic>.from(colour!.map((x) => x.toJson())),
    "Brand": brand == null ? null : List<dynamic>.from(brand!.map((x) => x.toJson())),
    "Model": model == null ? null : List<dynamic>.from(model!.map((x) => x.toJson())),
    "Operating System": operatingSystem == null ? null : List<dynamic>.from(operatingSystem!.map((x) => x.toJson())),
    "Internal Memory": internalMemory == null ? null : List<dynamic>.from(internalMemory!.map((x) => x.toJson())),
    "Resolution": resolution == null ? null : List<dynamic>.from(resolution!.map((x) => x.toJson())),
  };
}

class AttributeBrand {
  AttributeBrand({
    this.id,
    this.attrId,
    this.catId,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.selected,
  });

  int? id;
  int? attrId;
  int? catId;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? selected;

  factory AttributeBrand.fromJson(Map<String, dynamic> json) => AttributeBrand(
    id: json["id"]== null ? null : json["id"],
    attrId: json["attr_id"]== null ? null : json["attr_id"],
    catId: json["cat_id"]== null ? null : json["cat_id"],
    title: json["title"]== null ? null : json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"]== null ? null : json["deleted_at"],
    selected: json["selected"]== null ? null : json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attr_id": attrId,
    "cat_id": catId,
    "title": title,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "selected": selected,
  };
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"]== null ? null : json["id"],
    parentId: json["parent_id"]== null ? null : json["parent_id"],
    title: json["title"]== null ? null : json["title"],
    description: json["description"]== null ? null : json["description"],
    createdAt: DateTime.parse(json["created_at"]== null ? null : json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]== null ? null : json["updated_at"]),
    deletedAt: json["deleted_at"]== null ? null : json["deleted_at"],
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

class ProductAttribute {
  ProductAttribute({
    this.id,
    this.title,
    this.type,
    this.selected,
    this.colour,
    this.brand,
    this.model,
    this.operatingSystem,
    this.internalMemory,
    this.resolution,
  });

  int? id;
  String? title;
  Type? type;
  bool? selected;
  List<ProductAttributeBrand>? colour;
  List<ProductAttributeBrand>? brand;
  List<ProductAttributeBrand>? model;
  List<ProductAttributeBrand>? operatingSystem;
  List<ProductAttributeBrand>? internalMemory;
  List<ProductAttributeBrand>? resolution;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => ProductAttribute(
    id: json["id"]== null ? null : json["id"],
    title: json["title"]== null ? null : json["title"],
    type: typeValues.map![json["type"]== null ? null : json["type"]],
    selected: json["selected"]== null ? null : json["selected"],
    colour: json["Colour"] == null ? null : List<ProductAttributeBrand>.from(json["Colour"].map((x) => ProductAttributeBrand.fromJson(x))),
    brand: json["Brand"] == null ? null : List<ProductAttributeBrand>.from(json["Brand"].map((x) => ProductAttributeBrand.fromJson(x))),
    model: json["Model"] == null ? null : List<ProductAttributeBrand>.from(json["Model"].map((x) => ProductAttributeBrand.fromJson(x))),
    operatingSystem: json["Operating System"] == null ? null : List<ProductAttributeBrand>.from(json["Operating System"].map((x) => ProductAttributeBrand.fromJson(x))),
    internalMemory: json["Internal Memory"] == null ? null : List<ProductAttributeBrand>.from(json["Internal Memory"].map((x) => ProductAttributeBrand.fromJson(x))),
    resolution: json["Resolution"] == null ? null : List<ProductAttributeBrand>.from(json["Resolution"].map((x) => ProductAttributeBrand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": typeValues.reverse[type],
    "selected": selected,
    "Colour": colour == null ? null : List<dynamic>.from(colour!.map((x) => x.toJson())),
    "Brand": brand == null ? null : List<dynamic>.from(brand!.map((x) => x.toJson())),
    "Model": model == null ? null : List<dynamic>.from(model!.map((x) => x.toJson())),
    "Operating System": operatingSystem == null ? null : List<dynamic>.from(operatingSystem!.map((x) => x.toJson())),
    "Internal Memory": internalMemory == null ? null : List<dynamic>.from(internalMemory!.map((x) => x.toJson())),
    "Resolution": resolution == null ? null : List<dynamic>.from(resolution!.map((x) => x.toJson())),
  };
}

class ProductAttributeBrand {
  ProductAttributeBrand({
    this.id,
    this.title,
    this.type,
    this.color,
    this.selected,
  });

  int? id;
  String? title;
  Type? type;
  String? color;
  bool? selected;

  factory ProductAttributeBrand.fromJson(Map<String, dynamic> json) => ProductAttributeBrand(
    id: json["id"]== null ? null : json["id"],
    title: json["title"]== null ? null : json["title"],
    type: typeValues.map![json["type"]== null ? null : json["type"]],
    color: json["color"] == null ? null : json["color"],
    selected: json["selected"]== null ? null : json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": typeValues.reverse[type],
    "color": color == null ? null : color,
    "selected": selected,
  };
}

enum Type { TEXT, COLOR }

final typeValues = EnumValues({
  "color": Type.COLOR,
  "text": Type.TEXT
});

class Seller {
  Seller({
    this.name,
  });

  String? name;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
