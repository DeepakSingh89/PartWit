
import 'dart:convert';
import 'dart:developer';

import 'package:part_wit/model/ChatModel.dart';
import 'package:part_wit/model/FilteredProductModel.dart';
import 'package:part_wit/model/WelcomePartwitModel.dart';
import 'package:part_wit/utils/LoggingInterceptor.dart';


import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AboutPartWitModel.dart';
import 'package:part_wit/model/AddCardModel.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/AttributesModel.dart';
import 'package:part_wit/model/CateListListedForSaleDetailModel.dart';
import 'package:part_wit/model/CategoryListedForSaleModel.dart';
import 'package:part_wit/model/CommonResponse.dart';
import 'package:part_wit/model/DeleteCardModel.dart';
import 'package:part_wit/model/EditProductModel.dart';
import 'package:part_wit/model/FilterModel.dart';
import 'package:part_wit/model/HomeListModel.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/model/NotificationModel.dart';
import 'package:part_wit/model/PaymentModel.dart';
import 'package:part_wit/model/PrivacyPolicyModel.dart';
import 'package:part_wit/model/ProductByCategory.dart';
import 'package:part_wit/model/SavedItemsModel.dart';
import 'package:part_wit/model/SearchItemsModel.dart';
import 'package:part_wit/model/SellerProfileModel.dart';
import 'package:part_wit/model/SellerRecentItemsModel.dart';
import 'package:part_wit/model/SellerReviewsModel.dart';
import 'package:part_wit/model/SingleProductShowModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/model/TermsAndConditionsModel.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:part_wit/model/ReasonsModel.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:http_parser/http_parser.dart';
class ApiServices {
  /// get reason list
  static Future<ReasonsModel?> ReasonList(BuildContext context) async {
    // OverlayEntry loader = Helpers.overlayLoader(context);
    // Overlay.of(context)!.insert(loader);

    var url = ApiUrls.getReasonList;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );
    log('${response.body.toString()}');
    if (response.statusCode == 200) {
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        //  Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return reasonsModelFromJson(jsonString);
      } else {
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      //  Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return ReasonsModel.fromJson(json.decode(response.body));
  }

  /// get home list data
  static Future<HomeListModel?> getHomeListItems(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.getHomeList;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
    );

    log('!!! ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return homeListModelFromJson(jsonString);
      } else {
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return HomeListModel.fromJson(json.decode(response.body));
  }

  ///getProductByCategory
  static Future<ProductByCategory> getProductByCategory(
      String cat_id, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    log('cat id ${cat_id}');
    var url = ApiUrls.getProductByCategory;
    var map = <String, dynamic>{};
    map['cat_id'] = cat_id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    log('  ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return productByCategoryFromJson(jsonString);
      } else {
        //   Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return ProductByCategory.fromJson(json.decode(response.body));
  }

  ///add chat
  static Future<CommonResponse?> addChatUser(String userId,
        BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    var url = ApiUrls.addChat;
    var map = <String, dynamic>{};
    map['chat_with'] = userId;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
 body: map,
    );

    log('chAaat  ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return CommonResponse.fromJson(json.decode(response.body));
      } else {
        //   Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CommonResponse.fromJson(json.decode(response.body));
  }

  ///getChatList
  static Future<ChatModel?> getChatLis(
        BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    var url = ApiUrls.chatList;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},

    );

    log('chat  ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return chatModelFromJson(jsonString);
      } else {
        //   Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return ChatModel.fromJson(json.decode(response.body));
  }
  ///delete product
  static Future<CommonResponse?> deleteProduct(
        BuildContext context,String product_id) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    var url = ApiUrls.deleteProduct;
    var map = <String, dynamic>{};
    map['product_id'] = product_id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
  body: map,
    );

    log('delete  ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return CommonResponse.fromJson(json.decode(response.body));
      } else {
        //   Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CommonResponse.fromJson(json.decode(response.body));
  }

  /// home seller reviews
  static Future<SellerReviewsModel?> getSellerReviews(
      String seller_id, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response;

    if (seller_id == Constant.YOURS_REVIEWS) {
      response = await http.post(
        Uri.parse(ApiUrls.sellerSelfReviews),
        headers: {'Authorization': "Bearer " + user.token!},
      );
    } else {
      var map = <String, dynamic>{};
      map['seller_id'] = seller_id;

      response = await http.post(
        Uri.parse(ApiUrls.sellerReviews),
        headers: {'Authorization': "Bearer " + user.token!},
        body: map,
      );
    }


    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return sellerReviewsModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);

      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SellerReviewsModel.fromJson(json.decode(response.body));
  }

  /// home seller reviews
  static Future<SellerRecentItemsModel?> sellerRecentItems(
      BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.sellerResentListedItems;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return sellerRecentItemsModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SellerRecentItemsModel.fromJson(json.decode(response.body));
  }

  /// get Save Item List
  static Future<SavedItemsModel?> saveItemsList(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.saveItemsList;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );

    log('## ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return savedItemsModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      // Helpers.createSnackBar(
      //     context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SavedItemsModel.fromJson(json.decode(response.body));
  }

  static Future<CommonResponse> removeSavedItem(
      String id, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);
    var url = Uri.parse(ApiUrls.removeSaveItem);
    var map = <String, dynamic>{};
    map['save_item_id'] = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.post(
      url,
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    log('res ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];
      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        return CommonResponse.fromJson(json.decode(response.body));
      } else {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CommonResponse.fromJson(json.decode(response.body));
  }

  /// get notifications List
  static Future<NotificationModel?> getNotifications(
      BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.getNotification;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );

    log('notifications :-   ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return notificationModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return NotificationModel.fromJson(json.decode(response.body));
  }

  /// get Items for listed for sale List
  static Future<CateListListedForSaleModel?> getCatItemList(
      BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.cateListListedForSale;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );
log('cat  ${response.body.toString()}');

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return cateListListedForSaleModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CateListListedForSaleModel.fromJson(json.decode(response.body));
  }



  /// get Attributes List
  static Future<AttributesModel?> attributeList( String cat_id,
      BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.attributesList;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    var map = <String, dynamic>{};
    map['cat_id'] = cat_id;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

log('@@@ ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return attributesModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return AttributesModel.fromJson(json.decode(response.body));
  }

  /// seller-listed-products
  static Future<CateListListedForSaleDetailModel?> itemsListedForSale(
      String cat_id, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.sellerResentListedItems;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    var map = <String, dynamic>{};
    map['cat_id'] = cat_id;
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return cateListListedForSaleDetailModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CateListListedForSaleDetailModel.fromJson(
        json.decode(response.body));
  }

  /// get home list data
  static Future<SingleShowProductModel?> getSingleProductDetails(
      String proId, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.singleProductShow;
    var map = <String, dynamic>{};
    map['pro_id'] = proId;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    log('${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return singleShowProductModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SingleShowProductModel.fromJson(json.decode(response.body));
  }

  /// get seller profile
  static Future<SellerProfileModel?> getSellerProfile(
      String proId, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.sellerProfile;
    var map = <String, dynamic>{};
    map['seller_id'] = proId;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return sellerProfileModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SellerProfileModel.fromJson(json.decode(response.body));
  }

  /// Search Product list data
  static Future<SearchItemsModel?> searchProduct(
      String search, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.searchProduct;
    var map = <String, dynamic>{};
    map['search'] = search;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );
 log('search ${json.decode(response.body)['status']}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return searchItemsModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SearchItemsModel.fromJson(json.decode(response.body));
  }

  /// terms and conditions
  static Future<TermAndConditionModel?> termAndConditionApi(
      BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    String url = ApiUrls.termsConditionsApi;
    http.Response response = await http.get(
      Uri.parse(url),
    );

    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.hideLoader(loader);

      log('${response.body.toString()}');
      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return termAndConditionModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return TermAndConditionModel.fromJson(json.decode(response.body));
  }

  /// privacy policy
  static Future<PrivacyPolicyModel?> privacyPolicy(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    String url = ApiUrls.privacyPolicyApi;
    http.Response response = await http.get(
      Uri.parse(url),
    );

    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.hideLoader(loader);

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return privacyPolicyModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return PrivacyPolicyModel.fromJson(json.decode(response.body));
  }

  /// About us
  static Future<AboutPartWitModel?> aboutPartWit(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    String url = ApiUrls.aboutPartwit;
    http.Response response = await http.get(
      Uri.parse(url),
    );

    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.hideLoader(loader);

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return aboutPartWitModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return AboutPartWitModel.fromJson(json.decode(response.body));
  }
 /// About us
  static Future<WelcomePartwitModel?> welcomPartWit(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    String url = ApiUrls.welcomPartwit;
    http.Response response = await http.get(
      Uri.parse(url),
    );

    bool status;
    status = json.decode(response.body)['status'];
    if (status == true) {
      Helpers.hideLoader(loader);

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return welcomePartwitModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return WelcomePartwitModel.fromJson(json.decode(response.body));
  }

  ///*************** Subscription Plan Api *************///
  static Future<SubscriptionPlanModel?> subscriptionPlanApi(
      String type, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.subscriptionPlanApi;

    var map = <String, dynamic>{};
    map['subscription_type'] = type;

    http.Response? response;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    if (type == Constant.FEATURED) {
      response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': "Bearer " + user.token!},
        body: map,
      );
    } else {
      response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': "Bearer " + user.token!},
      );
    }

    log('${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      var jsonString = response.body;
      return subscriptionPlanModelFromJson(jsonString);
    } else if (response.statusCode == 500) {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(context, 'serverError'.tr);
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(context, 'serverError'.tr);
    }
    return null;
  }

  ///SubscriptionPlan list
  static Future<SubscriptionPlanModel?> subscriptionPlanList(
      String type, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.subscriptionPlanApi;

    var map = <String, dynamic>{};
    map['subscription_type'] = type;

    http.Response? response;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    if (type == Constant.FEATURED) {
      response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': "Bearer " + user.token!},
        body: map,
      );
    } else {
      response = await http.post(
        Uri.parse(url),
        headers: {'Authorization': "Bearer " + user.token!},
      );
    }

    log('data ${response.body.toString()}');

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      String status;
      status = json.decode(response.body)['status'];

      if (status == 'success') {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return subscriptionPlanModelFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return SubscriptionPlanModel.fromJson(json.decode(response.body));
  }

  /// All card list
  static Future<AllCardListPoJo?> allCardList(BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.allCardListApi;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      // body: map,
    );

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      String status;
      status = json.decode(response.body)['status'];

      if (status == 'success') {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return allCardListPoJoFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      // Helpers.createSnackBar(
      //     context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return AllCardListPoJo.fromJson(json.decode(response.body));
  }

  /// Add card
  static Future<AddCardPoJoFromJson?> addCard(
      BuildContext context, String cardToken) async {
    var url = ApiUrls.addCardApi;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: {"src_token": cardToken},
    );

    if (response.statusCode == 200) {
      String status;
      status = json.decode(response.body)['status'];

      if (status == "success") {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return addCardPoJoFromJsonFromJson(jsonString);
      } else {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
      }
    } else {
      // Helpers.createSnackBar(
      //     context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return AddCardPoJoFromJson.fromJson(json.decode(response.body));
  }

  ///*************** Payment Api *************///
  static Future<PaymentPoJo?> paymentApi(BuildContext context, String cardToken,
      String newType, String planId) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    String url = ApiUrls.paymentApi;
    var response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: {
        "subscription_id": planId,
        "isCardNew": "0",
        "src_token": cardToken
      },
    );

    log('######## ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      var jsonString = response.body;

      String? plan = pref.getString('plan');
      String? rating = pref.getString('rating');
      if(plan !=null){
        Utility.deleteValue(plan);
      }if(rating !=null){
        Utility.deleteValue(rating);
      }

      pref.setString('plan', json.decode(response.body)['user_info']['plan'].toString());
      pref.setString('rating', json.decode(response.body)['user_info']['rating'].toStringAsFixed(2));

      return paymentPoJoFromJson(jsonString);
    } else if (response.statusCode == 500) {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return null;
  }

  /// Delete card
  static Future<CardDeletePoJo?> deleteCard(
      BuildContext context, String cardToken) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.cardDeleteApi;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: {"src_token": cardToken},
    );

    print('&&&&&&&&&&deleted& ${response.statusCode}');
    print('&&&&&&&&&&deleted& ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        Helpers.hideLoader(loader);
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return cardDeletePoJoFromJson(jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CardDeletePoJo.fromJson(json.decode(response.body));
  }

  /// Add to Save Items
  static Future<CommonResponse?> addToSaveItems(
      String product_id, BuildContext context) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.itemAddToSaveList;
    var map = <String, dynamic>{};
    map['product_id'] = product_id;

    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

    log('${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        return CommonResponse.fromJson(json.decode(response.body));
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return CommonResponse.fromJson(json.decode(response.body));
  }

  /// Add products
  static Future<CommonResponse?> addProducts(
      String pro_id, String name,String short_desc,String description,String price,String category_id,
      List<String> product_attribut, List<String> product_attribut_values, BuildContext context, List<String> fileList, String? identity, List<int>? deleteIndex,  ) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

log('${name}');
log('${short_desc}');
log('${description}');
log('${price}');
log('${category_id}');
log('${product_attribut.toString()}');
log('${fileList.toString()}');

      var url = ApiUrls.addProducts;
    var map = <String, dynamic>{};
      if(identity==Constant.IDENTITY)
        {
          print('88888888888888888 ${identity}');
          print('88888888888888888 ${pro_id}');
          map['pro_id'] = pro_id;
          map['name'] = name;
          map['short_desc'] = short_desc;
          map['description'] = description;
          map['price'] = price;
          map['category_id'] = category_id;
          map['product_attributes'] = product_attribut.toString();
          map['attributes_value'] = product_attribut_values.toString();
          map['all_images'] = fileList.toString();
          map['deleted'] = deleteIndex.toString();
        }else{

        map['name'] = name;
        map['short_desc'] = short_desc;
        map['description'] = description;
        map['price'] = price;
        map['category_id'] = category_id;
        map['product_attributes'] = product_attribut.toString();
        map['attributes_value'] = product_attribut_values.toString();
        map['all_images'] = fileList.toString();
     }




    SharedPreferences pref = await SharedPreferences.getInstance();

    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
      log('${map.toString()}');
    final http = InterceptedHttp.build(interceptors: [
      LoggingInterceptor(),
    ]);

      final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );


      log('code ${response.statusCode}');
      log('${response.toString()}');

      if (response.statusCode == 200) {
        Helpers.hideLoader(loader);
        bool status;
        status = json.decode(response.body)['status'];


        if (status == true) {
          // Helpers.createSnackBar(
          //     context, json.decode(response.body)['message'].toString());
          return CommonResponse.fromJson(json.decode(response.body.toString()));
        } else {
          Helpers.hideLoader(loader);
          Helpers.createSnackBar(
              context, json.decode(response.body.toString())['message'].toString());
        }
      } else {
        Helpers.createSnackBar(context, "Exception : ");
        throw Exception(response.body.toString());
      }
      return CommonResponse.fromJson(json.decode(response.body.toString()));

  }


  /// Edit products
  static Future<EditProductModel?> getdetailProducts( BuildContext context,
      String pro_id, ) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.editProducts;
    var map = <String, dynamic>{};
   map['product_id'] = pro_id;


    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

log('@@${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return editProductModelFromJson (jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return EditProductModel.fromJson(json.decode(response.body));
  }

  ///Filter
  static Future<FilterModel?> getFilter( BuildContext context,
      String pro_id, ) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    var url = ApiUrls.filters;
    var map = <String, dynamic>{};
   map['category_id'] = pro_id;


    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

log('## ${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return filterModelFromJson (jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return FilterModel.fromJson(json.decode(response.body));
  }


  ///Filter products
  static Future<FilterProductModel?> getFilterProducts(String? category_id, List<String?> att_val, String? year_from, String? year_to, String? min_price, String? max_price, BuildContext context   ) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    print('${category_id}');
    print('${att_val.toString()}');
    print('${year_from}');
    print('${year_to}');
    print('${min_price}');
    print('${max_price}');
    var url = ApiUrls.filtersProducts;
    var map = <String, dynamic>{};
   map['category'] = category_id;
   map['attributes_value'] = att_val.toString();
   map['year_from'] = year_from;
   map['year_to'] = year_to;
   map['min_price'] = min_price;
   map['max_price'] = max_price;


    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': "Bearer " + user.token!},
      body: map,
    );

log('${response.body.toString()}');
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      bool status;
      status = json.decode(response.body)['status'];

      if (status == true) {
        // Helpers.createSnackBar(
        //     context, json.decode(response.body)['message'].toString());
        var jsonString = response.body;
        return filterProductModelFromJson (jsonString);
      } else {
        Helpers.hideLoader(loader);
        Helpers.createSnackBar(
            context, json.decode(response.body)['message'].toString());
      }
    } else {
      Helpers.hideLoader(loader);
      Helpers.createSnackBar(
          context, json.decode(response.body)['message'].toString());
      throw Exception(response.body);
    }
    return FilterProductModel.fromJson(json.decode(response.body));
  }
}
