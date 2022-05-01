import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AboutPartWitModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class AboutPartWitProvider extends ChangeNotifier{
  var aboutUs = AboutPartWitModel();
  bool loading = false;

  void  AboutPartWitData(BuildContext context) async {
    try{

      loading = false;
      notifyListeners();
      var response = await  ApiServices.aboutPartWit(context);
      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            aboutUs = response;
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