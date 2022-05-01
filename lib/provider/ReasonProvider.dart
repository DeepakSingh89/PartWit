import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:part_wit/model/ReasonsModel.dart';
import 'package:part_wit/network/ApiServices.dart';

class ReasonListProvider extends ChangeNotifier{
  var reasonsList = ReasonsModel();
  bool loading = false;

  void ReasonList(BuildContext context) async{

  try{

    loading = false;
    notifyListeners();

    var response = await  ApiServices.ReasonList(context);

      if (response != null) {
      loading = true;
      notifyListeners();

      if (response.status == true ) {
        if(response.data !=null){
          reasonsList = response;
            notifyListeners();
        }
      } else if (response.status == false) {

      }
    } else {
      loading = true;
      notifyListeners();
    //  Common.showSnackBar(ConstantsText.somethingWrongError, context, Colors.red);
    }
  }on SocketException {
    loading = true;
    notifyListeners();
 //   Common.showSnackBar(ConstantsText.internetIssue, context, Colors.red);
  } catch (exception) {
    loading = true;
    notifyListeners();
  //  Common.showSnackBar(ConstantsText.somethingWrongError, context, Colors.red);
  }

}
}