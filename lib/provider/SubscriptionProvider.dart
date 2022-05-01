import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/home_screen.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:get/get_core/src/get_main.dart';

class SubscriptionPlanProvider extends ChangeNotifier{
  
 var subscriptionPlansData = SubscriptionPlanModel();
  var allCardsData = AllCardListPoJo();
  bool loading = false;
 bool allCardLoading = false;

 /// ================ Subscription List

  void  subscriptionPlan(String type, BuildContext context) async {
    try{

     loading = false;
      notifyListeners();
      var response = await  ApiServices.subscriptionPlanList(type,context);

      if (response != null) {
        loading = true;
        notifyListeners();

        if (response.status == 'success') {
          if (response.data != null) {
            subscriptionPlansData = response;
            notifyListeners();
          }
        } else if (response.status == "fail") {
          loading = false;
            Helpers.createSnackBar(context, response.message.toString());

        }
      }else {
         loading = true;
          notifyListeners();

        Helpers.createSnackBar(context,  'serverError'.tr);
      }
    } on SocketException {
       loading = true;
        notifyListeners();
      Helpers.createSnackBar(context,  'internetIssue'.tr);

    } catch (exception) {
     loading = true;
      notifyListeners();
      Helpers.createSnackBar(context,  'serverError'.tr);
    }
  }

  ///=============== Add Card
  void addCard(BuildContext context, String cardToken) async{
    try {
   //   loading = false;
      var response = await ApiServices.addCard(context, cardToken);
      if (response != null) {
        if (response.status == "success") {
        //  loading = false;
          notifyListeners();
          if(response.data !=null){
           allCardList(context);
            notifyListeners();
          }
        } else if (response.status == "fail") {
         // loading = false;

         Helpers.createSnackBar(context,  response.message!);
        }
      } else {

        //loading = false;
       // Helpers.createSnackBar(context,  'serverError'.tr);
      }
    } on SocketException {
      //loading = false;
     // Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {

     // loading = false;
     // Helpers.createSnackBar(context,  'serverError'.tr);
    }
  }

  int isSelectedCard = -1;
  String? cardId;

  void selectCard(int i) {
    isSelectedCard = i;
    cardId = allCardsData.data!.data![i].id.toString();
    print('S1SS${cardId}');
    notifyListeners();
    print('SSS${cardId}');
  }

  ///================ All Card List
  void allCardList(BuildContext context) async{
    try {
     // loading = false;
      notifyListeners();
      var response = await ApiServices.allCardList(context);
      if (response != null) {
      //  loading = true;
        notifyListeners();
        if (response.status == "success") {
          if(response.data !=null && response.data!.data !=null && response.data!.data!.length > 0){
            allCardsData = response;
            notifyListeners();
          }
        } else if (response.status == "fail") {
          // Helpers.createSnackBar(context,  response.message.toString());

        }
      } else {
       // loading = true;
        notifyListeners();
        // Helpers.createSnackBar(context,  'serverError'.tr);
      }
    } on SocketException {
   //   loading = true;
      notifyListeners();
      // Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {
   //   loading = true;
      notifyListeners();
      // Helpers.createSnackBar(context,  'serverError'.tr);
    }
  }

  //=============== Delete Card
  void deleteCard(BuildContext context, String cardId) async{
    try {
    //  loading = false;
      var response = await ApiServices.deleteCard(context, cardId);
      if (response != null) {
        if (response.status == "success") {

        } else if (response.status == "fail") {
        //  loading = false;
        //   Helpers.createSnackBar(context,  response.message.toString());

        }
      } else {
      //  loading = false;
      //   Helpers.createSnackBar(context,  'somethingWrong'.tr);
      }
    } on SocketException {
   //   loading = false;
   //    Helpers.createSnackBar(context,  'internetNotWorking'.tr);
    } catch (exception) {
    //  loading = false;
    //   Helpers.createSnackBar(context,  'internetNotWorking'.tr);
    }
  }


  void payment(BuildContext context, String cardToken, String newType, String planId) async{
    print('---------- ${cardToken}');
    print('---------- ${newType}');
    print('---------- ${planId}');
    try {
     loading = false;
      var response = await ApiServices.paymentApi(context, cardToken, newType, planId);
     log('=======1======= ${response!.data}');
      if (response != null) {
        log('=======1======= ${response.data}');
        if (response.status == "success") {
         loading = false;
          Helpers.createSnackBar(context,  response.message.toString());
         // Get.toNamed(MyRouter.userProfile);
        // Navigator.pop(context);
         log('=======2======= ${response.data}');
         Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
                 builder: (context) => HomeScreen(4)),
             ModalRoute.withName("/HomeScreen"));
        } else if (response.status == "fail") {
         loading = false;
          Helpers.createSnackBar(context,  response.message.toString());
         log('=======3======= ${response.data}');
        }
      } else {
       loading = false;
       log('=======4======= ${response.message}');
        Helpers.createSnackBar(context,  'serverError'.tr);
      }
    } on SocketException {
     loading = false;
     log('=======4======= ${ SocketException}');
      Helpers.createSnackBar(context,  'internetIssue'.tr);
    } catch (exception) {
     loading = false;
     log('=======5======= ${ exception}');
      Helpers.createSnackBar(context,  'serverError'.tr);
    }
  }


  int isSelectedValue = 0;
  int selectedPlanId = 0;

  void selectPlan(int i)
  {
    isSelectedValue = i;
    selectedPlanId = subscriptionPlansData.data![i].id as int;
    notifyListeners();
    print("Selected  ID: " + selectedPlanId.toString());
  }
  
}