import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/AttributesModel.dart';
import 'package:part_wit/model/EditProductModel.dart';
import 'package:part_wit/model/FilterModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class FilterProvider extends ChangeNotifier{


  var filterData = FilterModel();
  bool loading = false;


  void filterList(String pro_id,BuildContext context) async{
    try {
      loading = false;
      notifyListeners();
      var response = await ApiServices.getFilter(context,pro_id);
      if (response != null) {
        loading = true;
        notifyListeners();
        if (response.status == true) {
          if(response.data !=null ){
            filterData = response;
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

  int isSelected  = -1;
  int isSelectedm  = -1;
  String?  Id;
  String?  mId;

  void selectCard(int i, int id, ) {
    isSelected = i;

     Id = id.toString();
    print('S1SS${ Id}');
    notifyListeners();
    print('SSS${ Id}');
  }
  void selectM_id(int i, int id, ) {
    isSelectedm = i;

    mId = id.toString();
    print('S1SS${mId}');
    notifyListeners();
    print('SSS${mId}');
  }
}