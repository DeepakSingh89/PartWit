import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/ReasonProvider.dart';
import 'package:part_wit/repository/product_report_repository.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/text/LightTextBodyFuturaPTMedium24_Black.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium24.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportListingDialog extends StatelessWidget {
  final String cat_id;

  ReportListingDialog(this.cat_id, {Key? key}) : super(key: key);


  String? rName ;
  String? pro_id, reason, moredetails;
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final detailFormKey = GlobalKey<FormState>();
  final reasonFormKey = GlobalKey<FormState>();
  FocusNode reasonFocus = FocusNode();



  dialogContent(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    // setState(() {
    Helpers.verifyInternet().then((intenet) {
      if (intenet) {
        WidgetsBinding.instance!
            .addPostFrameCallback((_) => {getReasonList(context)});
      } else {
        Helpers.createSnackBar(
            context, "Please check your internet connection");
      }
      // });
    });

    return GestureDetector(
      onTap: () {
        Utility.hideKeyboard(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyAppTheme.whiteColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
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
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: LightTextBodyFuturaPTMedium20(
                        data: 'reportListing'.tr,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: SvgPicture.asset(
                        MyImages.icClose,
                        alignment: Alignment.centerRight,
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {

                        _reasonBottomSheet(context);
                      },
                      child: Form(
                        key: reasonFormKey,
                        child: TextFormField(
                          enabled: false,

                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: MyAppTheme.black_Color,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w400,
                          ),
                          obscureText: false,
                          controller: _reasonController,
                          focusNode: reasonFocus,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'slctReason'.tr;
                            }
                            return null;
                          },
                          decoration: InputDecoration(

                            filled: true,
                            fillColor: MyAppTheme.textfield_bg_grayColor,
                            hintText: 'selectReason'.tr,
                            errorStyle: const TextStyle(color: Colors.red,),
                            hintStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: MyAppTheme.textPrimary,
                              fontFamily: Fonts.futurPT,
                              fontWeight: FontWeight.w100,
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15),
                              child:  Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.grey,
                              ),

                            ),
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: 20,
                              minHeight: 20,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: MyAppTheme.whiteColor),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: MyAppTheme.whiteColor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: MyAppTheme.whiteColor, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                    Container(
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: MyAppTheme.textfield_bg_grayColor,
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                        child: Container(
                          color: MyAppTheme.textfield_bg_grayColor,
                          child: Form(
                            key: detailFormKey,
                            child: TextFormField(
                              controller: _detailsController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 20,
                              textAlignVertical: TextAlignVertical.top,
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: MyAppTheme.textPrimary,
                                fontFamily: Fonts.futurPT,
                                fontWeight: FontWeight.w400,
                              ),
                              obscureText: false,
                              maxLength: 150,
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: MyAppTheme.textfield_bg_grayColor,
                                hintText: 'provideMoreDetail'.tr,
                                hintStyle: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: MyAppTheme.textPrimary,
                                  fontFamily: Fonts.futurPT,
                                  fontWeight: FontWeight.w100,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
                child: CustomButton(
                  'submit'.tr,
                  50,
                  onPressed: () {
                    try {


                      if (reasonFormKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(reasonFocus);

                        Helpers.verifyInternet().then((intenet) {
                          if (intenet) {
                            Navigator.pop(context);
                            productReport(cat_id,  _reasonController.text,
                                _detailsController.text, context)
                                .then((response) {
                                  if(response.status==true){
                                    print('##@@ ${response.message}');
                                toast(response.message);

                                  }
                            });

                          } else {
                            Helpers.createSnackBar(
                                context,
                                "Please check your internet connection");
                          }
                        });
                      }
                    } on Exception catch (e) {
                      e.printError();
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
            ],
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

  _reasonBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Consumer<ReasonListProvider>(
            builder: (context, modal, child) {
              return Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: LightTextBodyFuturaPTMediumBlack24(
                              data: 'selectReason'.tr,
                            ))),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02,
                    ),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 1,
                      child: modal.loading && modal.reasonsList.data != null
                          ? ListView.separated(
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                //    setState(() {
                                rName = modal.reasonsList.data![i].title
                                    .toString();
                                pro_id = modal.reasonsList.data![i].id
                                    .toString();
                                _reasonController.text = rName!;
                                //  });
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 10, bottom: 10),
                                alignment: Alignment.centerLeft,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    0.05,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 1,
                                child: Text(
                                  modal.reasonsList.data![i].title != null
                                      ? modal.reasonsList.data![i].title
                                      .toString()
                                      : '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.04),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) {
                            return const Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            );
                          },
                          itemCount: modal.reasonsList.data!.length)
                          : Helpers.loadingIndicator(Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
  Future<bool?> toast(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
    );
  }
}
getReasonList(BuildContext context) {
  Provider.of<ReasonListProvider>(context, listen: false).loading = false;

  Provider.of<ReasonListProvider>(context, listen: false).ReasonList(context);
}
