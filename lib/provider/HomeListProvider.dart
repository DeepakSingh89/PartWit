import 'dart:io';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/HomeListModel.dart';
import 'package:part_wit/network/ApiServices.dart';

class HomeListProvider extends ChangeNotifier{
  var homeListData =HomeListModel();
  bool loading = false;

  void  HomeListItems(BuildContext context) async {
    try{

      loading = false;
      notifyListeners();

      var response = await  ApiServices.getHomeListItems(context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            homeListData = response;
            notifyListeners();
          }
        } else if (response.status == false) {
          notifyListeners();
        }
      } else {
        loading = true;
        notifyListeners();

        Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    }on SocketException {
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