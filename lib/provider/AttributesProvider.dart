import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/AttributesModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class AttributeProvider extends ChangeNotifier{


  var attributeData = AttributesModel();

  bool loading = false;


  void attributesList(String cat_id,BuildContext context) async{
    try {
      loading = false;
      notifyListeners();
      var response = await ApiServices.attributeList(cat_id,context);
      if (response != null) {
        loading = true;
        notifyListeners();
        if (response.status == true) {
          if(response.data !=null ){
            attributeData = response;
            notifyListeners();
          }
        } else   {
          Helpers.createSnackBar(context,  response.message.toString());

        }
      } else {
        loading = true;
        notifyListeners();
        Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    } on SocketException {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    }
  }
  void editList(String cat_id,BuildContext context) async{
    try {
      loading = false;
      notifyListeners();
      var response = await ApiServices.attributeList(cat_id,context);
      if (response != null) {
        loading = true;
        notifyListeners();
        if (response.status == true) {
          if(response.data !=null ){
            attributeData = response;
            notifyListeners();
          }
        } else   {
          Helpers.createSnackBar(context,  response.message.toString());

        }
      } else {
        loading = true;
        notifyListeners();
        Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    } on SocketException {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    }
  }


}