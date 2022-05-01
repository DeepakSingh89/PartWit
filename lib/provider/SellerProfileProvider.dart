import 'dart:developer';
import 'dart:io';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/SellerProfileModel.dart';
import 'package:part_wit/model/SingleProductShowModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:part_wit/network/ApiServices.dart';

class SellerProfileProvider extends ChangeNotifier {
  var sellerProfileData = SellerProfileModel();
  bool loading = false;

  void sellerProfle(String proId, BuildContext context) async {
    try {
      loading = false;
      notifyListeners();
      var response = await ApiServices. getSellerProfile(proId, context);
      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true) {
          if (response.data != null) {
            sellerProfileData = response;
            notifyListeners();
          }
        } else if (response.status == false) {}
      } else {
        loading = true;
        notifyListeners();

        Helpers.createSnackBar(context, 'somethingWrongError'.tr);
      }
    } on SocketException {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context, 'internetIssue'.tr);
    } catch (exception) {
      loading = true;
      notifyListeners();
      Helpers.createSnackBar(context, 'internetIssue'.tr);
    }
  }
}
