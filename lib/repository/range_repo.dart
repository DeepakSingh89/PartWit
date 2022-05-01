import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/CommonResponse.dart';
import 'package:part_wit/model/FilterModel.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FilterModel?> range(
    BuildContext context,
    String pro_id,) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  var url = Uri.parse(ApiUrls.filters);
  var map = <String, dynamic>{};
  map['product_id'] = pro_id;
  SharedPreferences pref = await SharedPreferences.getInstance();
  var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
  http.Response response = await http.post(
    url,
    headers: {'Authorization':"Bearer "+user.token!},
    body: map,
  );
  log('## ${response.body.toString()}');
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    bool status = json.decode(response.body)['status'];
    if (status == true) {
      // Helpers.createSnackBar(
      //     context, json.decode(response.body)['message'].toString());
      var jsonString = response.body;
      return filterModelFromJson (jsonString);
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
  return FilterModel.fromJson(json.decode(response.body));
}