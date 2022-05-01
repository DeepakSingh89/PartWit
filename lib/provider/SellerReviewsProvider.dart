import 'dart:developer';
import 'dart:io';
import 'package:part_wit/model/SellerReviewsModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';


class SellerReviewProvider extends ChangeNotifier{
  var sellerRevieviws =SellerReviewsModel();
  bool loading = false;

  void  sellerReviews(String seller_id,BuildContext context) async {
    try{

      loading = false;
      notifyListeners();

      var response = await  ApiServices.getSellerReviews(seller_id,context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true ) {
          if(response.data !=null){
            sellerRevieviws = response;
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