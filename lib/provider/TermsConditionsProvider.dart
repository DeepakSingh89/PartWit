import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/TermsAndConditionsModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class TermsConditionProvider extends ChangeNotifier{
  var termAndConditionData = TermAndConditionModel();
  bool loading = false;

  void  termsCondtions(BuildContext context) async {
    try{

      loading = false;
      notifyListeners();
      var response = await  ApiServices.termAndConditionApi(context);
      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            termAndConditionData = response;
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