import 'dart:io';
import 'package:part_wit/model/NotificationModel.dart';
import 'package:part_wit/model/SavedItemsModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';


class NotificationProvider extends ChangeNotifier{
  var notificationData =NotificationModel();
  bool loading = false;

  void  notificationList(BuildContext context) async {
    try{

      loading = false;
      notifyListeners();

      var response = await  ApiServices.getNotifications( context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            notificationData = response;
            notifyListeners();
          }
        } else if (response.status == false) {

        }
      } else {
        loading = true;
        notifyListeners();

        Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    }on SocketException {
      print('@@@@@@@@@SocketException@ $SocketException');
      loading = true;
      notifyListeners();
      //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);

    } catch (exception) {
      print('@@@@@@@@@exception@ $exception');
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    }
  }

}