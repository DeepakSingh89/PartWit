
import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/utils/Helpers.dart';


class ToastProvider extends ChangeNotifier{
  void  Toast(BuildContext context) async {
    Helpers.createSnackBar(context,  'imgMsg'.tr);


  }
}