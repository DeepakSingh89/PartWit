import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:part_wit/model/ModelRegister.dart';

class ApiUrls {


  static const String secretKey = "sk_test_51EgyRrItQT8ZzyO1I06TwbGRQh8DTchlm51IBEGXL1AJWftWcuQqRG33A1q4BB8fipdPA398bM9NzU2flKii2NBf00L14WjNyA";
  static const String publicKey = "pk_test_xIudhR1N8ZnqHogumhfmpskw00NJg6zqor";



  static const String apiBaseUrl = 'http://15.206.212.50/api/';
  static const String loginUrl = apiBaseUrl + "login";
  static const String registerUrl = apiBaseUrl + "register";
  static const String sendVerificationOtp = apiBaseUrl + "send-verification-otp";
  static const String socialLoginUrl = apiBaseUrl + "social-login";
  static const String logoutUrl = apiBaseUrl + "logout";
  static const String verifyUserEmailOtpUrl = apiBaseUrl + "verify-user-email-otp";
  static const String resendEmailVerificationOtpUrl = apiBaseUrl + "resend-email-verification-otp";
  static const String sendForgotPasswordOtpMailUrl = apiBaseUrl + "send-forgot-password-otp-mail";
  static const String changeForgetPasswordUrl = apiBaseUrl + "change-forget-password";
  static const String updateUserDataUrl = apiBaseUrl + "update-user-data";
  static const String sendForgotPasswordOtpMail = apiBaseUrl + "send-forgot-password-otp-mail";
  static const String resendEmailVerificationOtp = apiBaseUrl + "resend-email-verification-otp";
  static const String updateUserData = apiBaseUrl + "v1/update-user-data";
  static const String verifyForgetPasswordOtp = apiBaseUrl + "verify-forget-password-otp";
  static const String verifyChangePassword= apiBaseUrl + "v1/change-password";

  static const String getReasonList= apiBaseUrl + "v1/report-reasons";
  static const String getHomeList= apiBaseUrl + "v1/home-page";
  static const String getProductByCategory= apiBaseUrl + "v1/products-by-category";
  static const String reportProduct= apiBaseUrl + "v1/report-product";

  static const String sellerReviews= apiBaseUrl + "v1/seller-reviews";
  static const String sellerSelfReviews= apiBaseUrl + "v1/seller-self-reviews";

  static const String addSellerReview= apiBaseUrl + "v1/add-seller-reviews";
  static const String  singleProductShow= apiBaseUrl + "v1/product-show";
  static const String  sellerProfile= apiBaseUrl + "v1/seller-profile";
  static const String  sellerResentListedItems= apiBaseUrl + "v1/seller-listed-products";
  static const String  saveItemsList= apiBaseUrl + "v1/save-items-list";
  static const String  removeSaveItem= apiBaseUrl + "v1/remove-save-item";
  static const String  getNotification= apiBaseUrl + "v1/notifications";

  static const String  searchProduct= apiBaseUrl + "v1/search";
  static const String  cateListListedForSale= apiBaseUrl + "v1/category-list";
  static const String  attributesList= apiBaseUrl + "v1/attributes-list";
  static const String  itemAddToSaveList= apiBaseUrl + "v1/add-to-save-item";
  static const String  addProducts= apiBaseUrl + "v1/product-add";
  static const String  editProducts= apiBaseUrl + "v1/edit-product";
  static const String  filters= apiBaseUrl + "v1/filters";
  static const String  filtersProducts= apiBaseUrl + "v1/filter-products";
  static const String  chatList= apiBaseUrl + "v1/chat-list";
  static const String  addChat= apiBaseUrl + "v1/add-chat";
  static const String  deleteProduct= apiBaseUrl + "v1/product-delete";

  ///static contents for server
  static const String termsConditionsApi= apiBaseUrl + "terms-conditions";
  static const String privacyPolicyApi= apiBaseUrl + "privacy-policy";
  static const String aboutPartwit= apiBaseUrl + "about-partwit";
  static const String welcomPartwit= apiBaseUrl + "welcome-to-partwit";

  ///payment Api's
  static const String addCardApi = apiBaseUrl +"v1/add-card";
  static const String allCardListApi = apiBaseUrl +"v1/all-cards";
  static const String cardDeleteApi = apiBaseUrl +"v1/delete-card";
  static const String subscriptionPlanApi = apiBaseUrl +"v1/subscription-plan-list";
  static const String paymentApi = apiBaseUrl +"v1/buy-subscription-plan";
}

logPrint(String logis) {
  log(logis);
}

ModeRegister? loginAndRegistrationresponse;

messageToastFalse(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 12.0);
}

messageToastTrue(BuildContext context, String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 12.0);
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}
