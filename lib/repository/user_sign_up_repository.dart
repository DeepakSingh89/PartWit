import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Future<ModeRegister> createRegister(
    String email, String name, String password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  Uri url = Uri.parse(ApiUrls.registerUrl);
  var map = <String, dynamic>{};
  map['email'] = email;
  map['name'] = name;
  map['profile_pic'] = profile_pic;
  map['password'] = password;
  map['password_confirmation'] = password;
  map['role'] = '2';
  http.Response response = await http.post(
    url,
    body: map,
  );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
     // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("id", json.decode(response.body)['user_info']['id'].toString());
      String user = jsonEncode(ModeRegister.fromJson(jsonDecode(response.body)));
      pref.setString('user', user);
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
*/

Future<ModeRegister> createRegistration(File fill, String email, String name,
    String password, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.registerUrl);
  var request = http.MultipartRequest(
    "POST",
    url,
  );
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
  // request.headers["Authorization"] = "Bearer " + user.token;
  request.fields["email"] = email;
  request.fields["name"] = name;
  request.fields["password"] = password;
  request.fields["password_confirmation"] = password;
  request.fields["role"] = '2';

  request.files.add(http.MultipartFile('profile_pic',
      File(fill.path).readAsBytes().asStream(), File(fill.path).lengthSync(),
      filename: fill.path.split("/").last));

  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  if ((response.statusCode) == 200) {
    Helpers.hideLoader(loader);
    var modelUser = ModeRegister.fromJson(jsonDecode(responseString));
    if (modelUser.status!) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String user = jsonEncode(ModeRegister.fromJson(jsonDecode(responseString)));
      pref.setString("id", modelUser.userInfo!.id.toString());
      pref.setString('user', user);
      return ModeRegister.fromJson(json.decode(responseString));
    } else {
      Helpers.createSnackBar(context, modelUser.message!);
    }
  } else {
    Helpers.createSnackBar(context, "Exception : ");
    throw Exception(responseString);
  }
  return ModeRegister.fromJson(json.decode(responseString));
}
