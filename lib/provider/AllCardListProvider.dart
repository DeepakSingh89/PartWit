import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class AllCardProvider extends ChangeNotifier{


  var allCardsData = AllCardListPoJo();
  bool loading = false;


  void allCardList(BuildContext context) async{
    try {
     loading = false;
      notifyListeners();
      var response = await ApiServices.allCardList(context);
      if (response != null) {
       loading = true;
        notifyListeners();
        if (response.status == "success") {
          if(response.data !=null && response.data!.data !=null && response.data!.data!.length > 0){
            allCardsData = response;
            notifyListeners();
          }
        } else if (response.status == "fail") {
          Helpers.createSnackBar(context,  response.message.toString());

        }
      } else {
       loading = true;
        notifyListeners();
       // Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    } on SocketException {
     loading = true;
      notifyListeners();
     // Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {
     loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    }
  }


}