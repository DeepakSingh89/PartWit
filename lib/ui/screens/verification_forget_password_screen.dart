import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/repository/resend_otp_repository.dart';
import 'package:part_wit/repository/verify_forget_password_otp.dart';
import 'package:part_wit/ui/screens/reset_new_password.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book17.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';

import 'package:pinput/pin_put/pin_put.dart';

class VerificationForgetPasswordScreen extends StatefulWidget {
  String otptyp, email;
  int? popupStatus = 0;

  VerificationForgetPasswordScreen(String this.email, this.otptyp) : super();

  @override
  State<VerificationForgetPasswordScreen> createState() =>
      _VerificationForgetPasswordScreenState(email, otptyp);
}

class _VerificationForgetPasswordScreenState
    extends State<VerificationForgetPasswordScreen> {
  final verificationFormKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String otpTyp, email;

  _VerificationForgetPasswordScreenState(this.email, this.otpTyp);

  Timer? timer;
  int _start = 29;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (mounted) {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if (mounted) {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: MyAppTheme.pin_bg_Color),
      borderRadius: BorderRadius.circular(5.0),
      color: MyAppTheme.pin_bg_Color,
    );
  }

  @override
  void initState() {
    if (widget.popupStatus == 1) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        _reSendCodePopUp(context, 'sendOTP'.tr,
            'otpSendTo'.tr + ' ' + widget.email.toString(), 'ok'.tr);
      });
    }
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final Object? rcvdData = ModalRoute.of(context)!.settings.arguments;

    return GestureDetector(
      onTap: () {
        Utility.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: MyAppTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: verificationFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.10,
                ),
                Center(
                  child: Image.asset(MyImages.ic_app_logo),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                  LightTextBodyFuturaPTHeavy34(
                  data: 'verification'.tr,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                  LightTextBodyFuturaPTBook17(
                  data: 'enter_verification_code'.tr,
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                LightTextBodyFuturaPTBook17(
                  data: 'sendTo'.tr + email,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            screenWidth * 0.150, 0, screenWidth * 0.150, 0),
                        color: MyAppTheme.backgroundColor,
                        child: PinPut(
                          fieldsCount: 4,
                          //onSubmit: (String pin) => _showSnackBar(pin, context),
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          cursorColor: MyAppTheme.whiteColor,
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: MyAppTheme.textPrimary,
                              fontFamily: Fonts.futurPT,
                              fontWeight: FontWeight.w600),
                          submittedFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.white.withOpacity(.5),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      CustomButton(
                        'submit'.tr,
                        54,
                        onPressed: () {
                          if (verificationFormKey.currentState!.validate()) {
                            FocusScope.of(this.context)
                                .requestFocus(FocusNode());
                            Helpers.verifyInternet().then((intenet) {
                              if (intenet) {
                                createVerifyForgetPasswordOtp(
                                        _pinPutController.text, context)
                                    .then((response) {
                                  setState(() {
                                    if (response.status == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetNewPassword(
                                                  email: email,
                                                )),
                                      );
                                    }
                                  });
                                });
                              } else {
                                Helpers.createSnackBar(context,
                                    "Please check your internet connection");
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                LightTextBodyFuturaPTBook14(data:'dontReceive'.tr),

                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                resendOtpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText resendOtpButton() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: MyAppTheme.textPrimary,
              fontFamily: Fonts.futurPT,
              fontWeight: FontWeight.w100,
            ),
            children: <TextSpan>[
          _start == 0
              ? TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //  otpTextCtrl.clear();
                      if (mounted) {
                        setState(() {
                          _start = 29;
                          startTimer();
                        });
                      }
                      _reSendCodePopUp(
                          context,
                          'sendOTP'.tr,
                          'otpSendTo'.tr + ' ' + widget.email.toString(),
                          'ok'.tr);
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: MyAppTheme.textPrimary,
                    fontFamily: Fonts.futurPT,
                    fontWeight: FontWeight.w100,
                  ),
                  text: 'resendCode'.tr,
                )
              : TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: MyAppTheme.textPrimary,
                    fontFamily: Fonts.futurPT,
                    fontWeight: FontWeight.w100,
                  ),
                  text: 'resendCode'.tr,
                ),
          _start == 0
              ? TextSpan(text: '')
              : TextSpan(text: ' in ' '$_start sec'),
        ]));
  }

  _reSendCodePopUp(
      BuildContext context, String title, String dis, String action) {
    final screenSize = MediaQuery.of(context).size;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                height: screenSize.height * 0.20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    LightTextBodyFuturaPTHeavy28(
                      data: title,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: LightTextBodyFuturaPTLight15(
                          data: dis,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Helpers.verifyInternet().then((intenet) {
                            if (intenet) {
                              createResendOtp(otpTyp, email, context)
                                  .then((response) {
                                setState(() {
                                  if (response.status == true) {
                                    // Get.toNamed(MyRouter.createProfile,
                                    //   arguments: Constant.PASS_VALUE);
                                  }
                                });
                              });
                            } else {
                              Helpers.createSnackBar(context,
                                  "Please check your internet connection");
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: LightTextBodyFuturaPTBold18(data: action,),
                        )),
                  ],
                ),
              ));
        });
  }
}
