


import 'dart:convert';

AllCardListPoJo allCardListPoJoFromJson(String str) => AllCardListPoJo.fromJson(json.decode(str));

String allCardListPoJoToJson(AllCardListPoJo data) => json.encode(data.toJson());

class AllCardListPoJo {
  AllCardListPoJo({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory AllCardListPoJo.fromJson(Map<String, dynamic> json) => AllCardListPoJo(
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
    this.object,
    this.data,
    this.hasMore,
    this.url,
  });

  String? object;
  List<CardData>? data;
  bool? hasMore;
  String? url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    object: json["object"],
    data: List<CardData>.from(json["data"].map((x) => CardData.fromJson(x))),
    hasMore: json["has_more"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "has_more": hasMore,
    "url": url,
  };
}

class CardData {
  CardData({
    this.id,
    this.object,
    this.addressCity,
    this.addressCountry,
    this.addressLine1,
    this.addressLine1Check,
    this.addressLine2,
    this.addressState,
    this.addressZip,
    this.addressZipCheck,
    this.brand,
    this.country,
    this.customer,
    this.cvcCheck,
    this.dynamicLast4,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.last4,
    this.metadata,
    this.name,
    this.tokenizationMethod,
  });

  String? id;
  String? object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String? brand;
  String? country;
  String? customer;
  dynamic cvcCheck;
  dynamic dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  List<dynamic>? metadata;
  dynamic name;
  dynamic tokenizationMethod;

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
    id: json["id"],
    object: json["object"],
    addressCity: json["address_city"],
    addressCountry: json["address_country"],
    addressLine1: json["address_line1"],
    addressLine1Check: json["address_line1_check"],
    addressLine2: json["address_line2"],
    addressState: json["address_state"],
    addressZip: json["address_zip"],
    addressZipCheck: json["address_zip_check"],
    brand: json["brand"],
    country: json["country"],
    customer: json["customer"],
    cvcCheck: json["cvc_check"],
    dynamicLast4: json["dynamic_last4"],
    expMonth: json["exp_month"],
    expYear: json["exp_year"],
    fingerprint: json["fingerprint"],
    funding: json["funding"],
    last4: json["last4"],
    metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
    name: json["name"],
    tokenizationMethod: json["tokenization_method"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "address_city": addressCity,
    "address_country": addressCountry,
    "address_line1": addressLine1,
    "address_line1_check": addressLine1Check,
    "address_line2": addressLine2,
    "address_state": addressState,
    "address_zip": addressZip,
    "address_zip_check": addressZipCheck,
    "brand": brand,
    "country": country,
    "customer": customer,
    "cvc_check": cvcCheck,
    "dynamic_last4": dynamicLast4,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "last4": last4,
    "metadata": List<dynamic>.from(metadata!.map((x) => x)),
    "name": name,
    "tokenization_method": tokenizationMethod,
  };
}


// import 'dart:convert';
//
// AllCardListPoJo allCardListPoJoFromJson(String str) => AllCardListPoJo.fromJson(json.decode(str));
//
// String allCardListPoJoToJson(AllCardListPoJo data) => json.encode(data.toJson());
//
// class AllCardListPoJo {
//   AllCardListPoJo({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   String? status;
//   String? message;
//   Data? data;
//
//   factory AllCardListPoJo.fromJson(Map<String, dynamic> json) => AllCardListPoJo(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data!.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.object,
//     this.data,
//     this.hasMore,
//     this.url,
//   });
//
//   String? object;
//   List<CardData>? data;
//   bool? hasMore;
//   String? url;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     object: json["object"],
//     data: List<CardData>.from(json["data"].map((x) => CardData.fromJson(x))),
//     hasMore: json["has_more"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "object": object,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//     "has_more": hasMore,
//     "url": url,
//   };
// }
//
// class CardData {
//   CardData({
//     this.id,
//     this.object,
//     this.addressCity,
//     this.addressCountry,
//     this.addressLine1,
//     this.addressLine1Check,
//     this.addressLine2,
//     this.addressState,
//     this.addressZip,
//     this.addressZipCheck,
//     this.brand,
//     this.country,
//     this.customer,
//     this.cvcCheck,
//     this.dynamicLast4,
//     this.expMonth,
//     this.expYear,
//     this.fingerprint,
//     this.funding,
//     this.last4,
//     this.metadata,
//     this.name,
//     this.tokenizationMethod,
//   });
//
//   String? id;
//   Object? object;
//   dynamic addressCity;
//   dynamic addressCountry;
//   dynamic addressLine1;
//   dynamic addressLine1Check;
//   dynamic addressLine2;
//   dynamic addressState;
//   dynamic addressZip;
//   dynamic addressZipCheck;
//   Brand? brand;
//   Country? country;
//   Customer? customer;
//   dynamic cvcCheck;
//   dynamic dynamicLast4;
//   int? expMonth;
//   int? expYear;
//   Fingerprint? fingerprint;
//   Funding? funding;
//   String? last4;
//   List<dynamic>? metadata;
//   dynamic name;
//   dynamic tokenizationMethod;
//
//   factory CardData.fromJson(Map<String, dynamic> json) => CardData(
//     id: json["id"],
//     object: objectValues.map![json["object"]],
//     addressCity: json["address_city"],
//     addressCountry: json["address_country"],
//     addressLine1: json["address_line1"],
//     addressLine1Check: json["address_line1_check"],
//     addressLine2: json["address_line2"],
//     addressState: json["address_state"],
//     addressZip: json["address_zip"],
//     addressZipCheck: json["address_zip_check"],
//     brand: brandValues.map![json["brand"]],
//     country: countryValues.map![json["country"]],
//     customer: customerValues.map![json["customer"]],
//     cvcCheck: json["cvc_check"],
//     dynamicLast4: json["dynamic_last4"],
//     expMonth: json["exp_month"],
//     expYear: json["exp_year"],
//     fingerprint: fingerprintValues.map![json["fingerprint"]],
//     funding: fundingValues.map![json["funding"]],
//     last4: json["last4"],
//     metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
//     name: json["name"],
//     tokenizationMethod: json["tokenization_method"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "object": objectValues.reverse[object],
//     "address_city": addressCity,
//     "address_country": addressCountry,
//     "address_line1": addressLine1,
//     "address_line1_check": addressLine1Check,
//     "address_line2": addressLine2,
//     "address_state": addressState,
//     "address_zip": addressZip,
//     "address_zip_check": addressZipCheck,
//     "brand": brandValues.reverse[brand],
//     "country": countryValues.reverse[country],
//     "customer": customerValues.reverse[customer],
//     "cvc_check": cvcCheck,
//     "dynamic_last4": dynamicLast4,
//     "exp_month": expMonth,
//     "exp_year": expYear,
//     "fingerprint": fingerprintValues.reverse[fingerprint],
//     "funding": fundingValues.reverse[funding],
//     "last4": last4,
//     "metadata": List<dynamic>.from(metadata!.map((x) => x)),
//     "name": name,
//     "tokenization_method": tokenizationMethod,
//   };
// }
//
// enum Brand { MASTER_CARD, VISA }
//
// final brandValues = EnumValues({
//   "MasterCard": Brand.MASTER_CARD,
//   "Visa": Brand.VISA
// });
//
// enum Country { US }
//
// final countryValues = EnumValues({
//   "US": Country.US
// });
//
// enum Customer { CUS_L1_NU_XV_L98_BTF_KZ }
//
// final customerValues = EnumValues({
//   "cus_L1NuXvL98btfKz": Customer.CUS_L1_NU_XV_L98_BTF_KZ
// });
//
// enum Fingerprint { THE_23_HS_WL_XBE0_YLQ_G_BD, J_H0_DC_BK_YG_RBY_WUEE, V_DV_LF_KJ_ZGK7_FP_EQE }
//
// final fingerprintValues = EnumValues({
//   "jH0dcBkYgRbyWUEE": Fingerprint.J_H0_DC_BK_YG_RBY_WUEE,
//   "23hsWlXBE0ylqGBd": Fingerprint.THE_23_HS_WL_XBE0_YLQ_G_BD,
//   "vDvLfKjZGK7fpEqe": Fingerprint.V_DV_LF_KJ_ZGK7_FP_EQE
// });
//
// enum Funding { CREDIT }
//
// final fundingValues = EnumValues({
//   "credit": Funding.CREDIT
// });
//
// enum Object { CARD }
//
// final objectValues = EnumValues({
//   "card": Object.CARD
// });
//
// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) =>   MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
//
