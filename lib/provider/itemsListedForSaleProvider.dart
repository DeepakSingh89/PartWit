import 'dart:io';
import 'package:part_wit/model/CateListListedForSaleDetailModel.dart';
import 'package:part_wit/model/SellerRecentItemsModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';



class ItemsListedForSaleProvider extends ChangeNotifier{
  var listedForSaleItems =CateListListedForSaleDetailModel();
  bool loading = false;

  void   productItemsList(String cat_id,BuildContext context) async {
    try{

      loading = false;
      notifyListeners();

      var response = await  ApiServices.itemsListedForSale(cat_id, context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            listedForSaleItems = response;
            notifyListeners();
          }
        } else if (response.status == false) {
          Helpers.createSnackBar(context,  response.message!);
        }
      } else {
        loading = true;
        notifyListeners();

        Helpers.createSnackBar(context,  'somethingWrongError'.tr);
      }
    }on SocketException {

      loading = true;
      notifyListeners();
      //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);

    } catch (exception) {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    }
  }

}