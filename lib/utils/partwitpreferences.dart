import 'dart:convert';
import 'package:part_wit/model/LoginModel.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class t_datingPreferences {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }

  saveUserLoginSession(Map login) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var map = login.toJson();
    logPrint("Login DATA SAVE IN SHARED PREFRENCE ::::: - " + login.toString() ?? "");

    var str = json.encode(login);
    prefs.setString("loginsession", str);
  }

  getLoginData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString("loginsession");
    if (value != null) {
      Map<String, dynamic> map = json.decode(value);
      logPrint("Login DATA GET IN SHARED PREFRENCE ::::: - ${map.toString()}");
      loginAndRegistrationresponse = ModeRegister.fromJson(map);
    } else {
      loginAndRegistrationresponse = null;
    }
  }
  logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
