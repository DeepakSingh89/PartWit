import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/CommonResponse.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<CommonResponse> productReport(
    String product_id,String reason,String more_details, BuildContext context) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.reportProduct);
  var map = <String, dynamic>{};
  map['product_id'] = product_id;
  map['reason'] = reason;
  map['more_details'] = more_details;
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
  http.Response response = await http.post(
    url,
    headers: {'Authorization':"Bearer "+user.token!},
    body: map,
  );
  print('***********( ${response.statusCode}');
  print('***********( ${response.body.toString()}');
  if (response.statusCode == 200) {

    Helpers.hideLoader(loader);
    bool status = json.decode(response.body)['status'];
    if (status == true) {
      print('@@@ ${json.decode(response.body)['message'].toString()}');
      String msg=json.decode(response.body)['message'].toString();
      // Helpers.createSnackBar(
      //     context,msg);
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