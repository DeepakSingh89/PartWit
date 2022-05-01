import 'dart:io';
import 'package:part_wit/model/FilteredProductModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:part_wit/network/ApiServices.dart';

class HomeFilterProductProvider extends ChangeNotifier{
  var homefilterData =FilterProductModel();
  bool loading = false;

  void  homeFilterProducts(String? category_id, List<String?> att_val, String? year_from, String? year_to, String? min_price, String? max_price, BuildContext context  ) async {
    try{

      loading = false;
      notifyListeners();

      var response = await  ApiServices.getFilterProducts(category_id,att_val,year_from,year_to,min_price,max_price,context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            homefilterData = response;
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