import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/repository/add_seller_reviews_repo.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SellerReviewDailog extends StatefulWidget {
  String imgUrl, seller_id;

  SellerReviewDailog(this.imgUrl, this.seller_id) : super();

  @override
  State<SellerReviewDailog> createState() =>
      _SellerReviewDailogState(imgUrl, seller_id);
}

class _SellerReviewDailogState extends State<SellerReviewDailog> {
  final double _initialRating = 0.0;
  final bool _isVertical = false;
  IconData? _selectedIcon;
  double? _rating;
  String imgUrl, seller_id;

  _SellerReviewDailogState(
    this.imgUrl,
    this.seller_id,
  );

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _rating = _initialRating;
  }

  dialogContent(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          ///hide keyboard function
          Utility.hideKeyboard(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: MyAppTheme.buttonColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: [
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    LightTextBodyFuturaPTHeavy18(
                      data: 'leaveReviewFor'.tr,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.03,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(imgUrl),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.07,
                    ),
                  ],
                ),
                _ratingBar(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                          ),
                          obscureText: false,
                          maxLength: 150,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: MyAppTheme.buttonShadow_Color,
                            hintText: 'reviewDetails'.tr,
                            hintStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: MyAppTheme.textPrimary,
                              fontFamily: Fonts.futurPT,
                              fontWeight: FontWeight.w100,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: MyAppTheme.buttonShadow_Color),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyAppTheme.buttonShadow_Color),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: MyAppTheme.buttonShadow_Color,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: LightTextBodyFuturaPTHeavy18(
                        data: 'cancel'.tr,
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        try {
                          if (_rating != null) {
                            Helpers.verifyInternet().then((intenet) {
                              if (intenet) {
                                Navigator.pop(context);
                                sellerReviewsAdd(seller_id, _rating!.toStringAsFixed(2),
                                    _descriptionController.text, context) ;
                              } else {
                                Helpers.createSnackBar(context,
                                    "Please check your internet connection");
                              }
                            });
                          }
                        } on Exception catch (e) {
                          e.printError();
                        }
                      },
                      child: LightTextBodyFuturaPTHeavy18(
                        data: 'submit'.tr,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.05,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      ///filter for blur background
      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(
          context,
        ),
      ),
    );
  }

  ///ratingBar
  _ratingBar() {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: _isVertical ? Axis.vertical : Axis.horizontal,
      allowHalfRating: true,
      unratedColor:  MyAppTheme.box_bg_grayColor,
      itemCount: 5,
      itemSize: 40.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
