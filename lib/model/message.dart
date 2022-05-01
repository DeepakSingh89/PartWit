import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message {
  final String senderName;
  final String content;
  final String img;
final String imgUrl;
  final DateTime date;

  const Message(this.senderName, this.content, this.img,this.imgUrl,  this.date);

  bool isUserMessage(String senderName) => this.senderName == senderName;

  String toJson() => json.encode({
        'senderName': senderName,
        'content': content,
        'img': img,
        'imgUrl': imgUrl,

        'date': date.toString(),
      });

  static Message fromJson(Map<String, dynamic> data) {
    return Message(
      data['senderName'],
      data['content'],
      data['img'],
      data['imgUrl'],

      DateTime.parse(data['date']),
    );
  }
}
