import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<ModeRegister> createUserUpdateData(
    File fill, String name, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.updateUserData);
  var request = http.MultipartRequest(
    "POST",
    url,
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
  request.headers["Authorization"] = "Bearer " + user.token!;
  request.fields["name"] = name;
  if (fill.path.isNotEmpty) {
    request.files.add(http.MultipartFile('profile_pic',
        File(fill.path).readAsBytes().asStream(), File(fill.path).lengthSync(),
        filename: fill.path.split("/").last));
  }
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  if ((response.statusCode) == 200) {
    Helpers.hideLoader(loader);
    var modelUser = ModeRegister.fromJson(jsonDecode(responseString));
    if (modelUser.status!) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String user = jsonEncode(ModeRegister.fromJson(jsonDecode(responseString)));
      pref.setString('user', user);
    }  else {
      Helpers.createSnackBar(context, modelUser.message!);
    }
    return ModeRegister.fromJson(json.decode(responseString));
  } else {
    Helpers.createSnackBar(context, "Exception : ");
    throw Exception(responseString);
  }
  return ModeRegister.fromJson(json.decode(responseString));
}
