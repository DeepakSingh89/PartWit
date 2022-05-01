// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
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
    this.name,
    this.profilePic,
  });

  String? name;
  String? profilePic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile_pic": profilePic,
  };
}
