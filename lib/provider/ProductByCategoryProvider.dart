import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/ProductByCategory.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/utils/Helpers.dart';

class ProductByCateProvider extends ChangeNotifier{
 var productData =ProductByCategory();
  bool loading = false;

  void ProductByCat(String cat_id,BuildContext context) async {
    try{
      loading = false;
      notifyListeners();

      var response = await  ApiServices.getProductByCategory(cat_id,context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            productData = response;
            notifyListeners();
          }
        } else if (response.status == false) {
         // Helpers.createSnackBar(context,  'noRecord'.tr);
        }
      } else {
        loading = true;
        notifyListeners();

       // Helpers.createSnackBar(context,  'somethingWrong'.tr);
      }
    }on SocketException {
      loading = true;
      notifyListeners();
    //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);

    } catch (exception) {
      loading = true;
      notifyListeners();
    //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);
    }
  }

}