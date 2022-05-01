import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/CommonResponse.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';

Future<CommonResponse> createVerifyForgetPasswordOtp(
    String otp, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.verifyForgetPasswordOtp);
  bool forget = true;
  var map = <String, dynamic>{};
  map['forget_password'] = forget.toString();
  map['otp'] = otp;
  http.Response response = await http.post(
    url,
    body: map,
  );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      return CommonResponse.fromJson(json.decode(response.body));
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
  return CommonResponse.fromJson(json.decode(response.body));
}
