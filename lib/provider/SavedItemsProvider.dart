import 'dart:io';
import 'package:part_wit/model/SavedItemsModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';

class SavedItemsProvider extends ChangeNotifier {
  var savedItems = SavedItemsModel();
  bool loading = false;

  void savedItemsList(BuildContext context) async {
    try {
      loading = false;
      notifyListeners();

      var response = await ApiServices.saveItemsList(context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == true) {
          notifyListeners();
          if (response.data != null) {
            savedItems = response;
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
      //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);

    } catch (exception) {
      loading = true;
      notifyListeners();
      //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);
    }
  }
// void  removeItemsList(String id,BuildContext context) async {
//   try{
//
//     loading = false;
//     notifyListeners();
//
//     var response = await  ApiServices.removeSavedItem(id, context);
//
//     if (response != null) {
//       loading = true;
//
//       if (response.status == true ) {
//         notifyListeners();
//         if(response.status !=null){
//           savedItemsList(context);
//           notifyListeners();
//         }
//       } else if (response.status == false) {
//
//       }
//     } else {
//       loading = true;
//       notifyListeners();
//
//       Helpers.createSnackBar(context,  'somethingWrong'.tr);
//     }
//   }on SocketException {
//
//     loading = true;
//     notifyListeners();
//     //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);
//
//   } catch (exception) {
//
//     loading = true;
//     notifyListeners();
//   //  Helpers.createSnackBar(context,  'internetNotWorking'.tr);
//   }
// }

}
