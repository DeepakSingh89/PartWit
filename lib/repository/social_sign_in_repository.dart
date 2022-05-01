import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';

Future<ModeRegister> createRegister(String socialId, String socialType, String mobile,
    String email, String password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  Uri url = Uri.parse(ApiUrls.registerUrl);
  Map<String, dynamic> map = postParam(socialId, socialType, email, mobile);

  http.Response response = await http.post(
    url,
    body: map,
  );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      return ModeRegister.fromJson(json.decode(response.body));
    } else {
      Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
    }
  } else {
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
    throw Exception(response.body);
  }
  return ModeRegister.fromJson(json.decode(response.body));
}

Map<String, dynamic> postParam(String socialId, String socialType, String email, String mobile) {
  var map = <String, dynamic>{};
  map['social_id'] = socialId;
  map['social_type'] = socialType;
  map['email'] = email;
  map['mobile'] = mobile;
  map['device_id'] = '43346436';

  return map;
}
