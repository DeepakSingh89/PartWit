// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
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
    this.attributes,
    this.yearRange,
    this.priceRange,
  });

  List<Attribute>? attributes;
  List<YearRange>? yearRange;
  List<PriceRange>? priceRange;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attributes: List<Attribute>.from(json["attributes"].map((x) => Attribute.fromJson(x))),
    yearRange: List<YearRange>.from(json["year_range"].map((x) => YearRange.fromJson(x))),
    priceRange: List<PriceRange>.from(json["price_range"].map((x) => PriceRange.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
    "year_range": List<dynamic>.from(yearRange!.map((x) => x.toJson())),
    "price_range": List<dynamic>.from(priceRange!.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
    this.id,
    this.title,
    this.type,
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
  List<Brand>? colour;
  List<Brand>? brand;
  List<Brand>? model;
  List<Brand>? operatingSystem;
  List<Brand>? internalMemory;
  List<Brand>? resolution;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    title: json["title"],
    type: typeValues.map![json["type"]],
    colour: json["Colour"] == null ? null : List<Brand>.from(json["Colour"].map((x) => Brand.fromJson(x))),
    brand: json["Brand"] == null ? null : List<Brand>.from(json["Brand"].map((x) => Brand.fromJson(x))),
    model: json["Model"] == null ? null : List<Brand>.from(json["Model"].map((x) => Brand.fromJson(x))),
    operatingSystem: json["Operating System"] == null ? null : List<Brand>.from(json["Operating System"].map((x) => Brand.fromJson(x))),
    internalMemory: json["Internal Memory"] == null ? null : List<Brand>.from(json["Internal Memory"].map((x) => Brand.fromJson(x))),
    resolution: json["Resolution"] == null ? null : List<Brand>.from(json["Resolution"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": typeValues.reverse[type],
    "Colour": colour == null ? null : List<dynamic>.from(colour!.map((x) => x.toJson())),
    "Brand": brand == null ? null : List<dynamic>.from(brand!.map((x) => x.toJson())),
    "Model": model == null ? null : List<dynamic>.from(model!.map((x) => x.toJson())),
    "Operating System": operatingSystem == null ? null : List<dynamic>.from(operatingSystem!.map((x) => x.toJson())),
    "Internal Memory": internalMemory == null ? null : List<dynamic>.from(internalMemory!.map((x) => x.toJson())),
    "Resolution": resolution == null ? null : List<dynamic>.from(resolution!.map((x) => x.toJson())),
  };
}

class Brand {
  Brand({
    this.id,
    this.title,
    this.type,
    this.color,
  });

  int? id;
  String? title;
  Type? type;
  String? color;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    title: json["title"],
    type: typeValues.map![json["type"]],
    color: json["color"] == null ? null : json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": typeValues.reverse[type],
    "color": color == null ? null : color,
  };
}

enum Type { TEXT, COLOR }

final typeValues = EnumValues({
  "color": Type.COLOR,
  "text": Type.TEXT
});

class PriceRange {
  PriceRange({
    this.minPrice,
    this.maxPrice,
  });

  int? minPrice;
  int? maxPrice;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
    minPrice: json["min_price"] == null ? null : json["min_price"],
    maxPrice: json["max_price"] == null ? null : json["max_price"],
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice == null ? null : minPrice,
    "max_price": maxPrice == null ? null : maxPrice,
  };
}

class YearRange {
  YearRange({
    this.minYear,
    this.maxYear,
  });

  String? minYear;
  String? maxYear;

  factory YearRange.fromJson(Map<String, dynamic> json) => YearRange(
    minYear: json["min_year"] == null ? null : json["min_year"],
    maxYear: json["max_year"] == null ? null : json["max_year"],
  );

  Map<String, dynamic> toJson() => {
    "min_year": minYear == null ? null : minYear,
    "max_year": maxYear == null ? null : maxYear,
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
