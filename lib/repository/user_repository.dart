import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<ModeRegister> createLogin(
    String email, String password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.loginUrl);
  var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;
  map['device_id'] = '1476402def040d58';
  map['role'] = '2';
  http.Response response = await http.post(
    url,
    body: map,
  );

  log('${response.body.toString()}');
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("id", json.decode(response.body)['user_info']['id'].toString());
      pref.setString('plan', json.decode(response.body)['user_info']['plan'].toString());
      pref.setString('rating', json.decode(response.body)['user_info']['rating'].toString());
      String user = jsonEncode(ModeRegister.fromJson(jsonDecode(response.body)));
      pref.setString('user', user);
      return ModeRegister.fromJson(json.decode(response.body));
    } else {
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
    }
  } else {
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(
        context, json.decode(response.body)['message'].toString());
    throw Exception(response.body);
  }
  return ModeRegister.fromJson(json.decode(response.body));
}
