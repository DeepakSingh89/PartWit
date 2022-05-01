import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/repository/resend_otp_repository.dart';
import 'package:part_wit/repository/verify_user_email_otp.dart';

import 'package:part_wit/ui/screens/create_profile_screen.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';


import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book13.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book17.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light15.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';

import 'package:part_wit/utils/Helpers.dart';

import 'package:part_wit/utils/utility.dart';

import 'package:pinput/pin_put/pin_put.dart';

class VerificationScreen extends StatefulWidget {
  String otpType, password, email;
  int? popupStatus = 0;
  VerificationScreen(String this.email, String this.password, String this.otpType) : super();

  @override
  State<VerificationScreen> createState() =>
      _VerificationScreenState(email, password, otpType);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final verification_formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String otpType, email, password;
  bool _isAgreeCheckBox = true;
  _VerificationScreenState(String this.email, String this.password, String this.otpType);

  Timer? timer;
  int _start = 29;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer =   Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          if(mounted)
          {
            setState(() {
              timer.cancel();
            });
          }
        } else {
          if(mounted)
          {
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
      border: Border.all(color: MyAppTheme.greenColor),
      borderRadius: BorderRadius.circular(5.0),
      color: MyAppTheme.pin_bg_Color,
    );
  }

@override
  void initState() {
  if(widget.popupStatus == 1){
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _reSendCodePopUp(context, 'sendOTP'.tr, 'otpSendTo'.tr +' '+ widget.email.toString(), 'ok'.tr);
    });
  }
  startTimer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Utility.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: MyAppTheme.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: verification_formKey,
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
                    data: '2StepVerification'.tr,
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
                            autofocus: true,
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
                          height: screenSize.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _isAgreeCheckBox = !_isAgreeCheckBox;
                                  });
                                },
                                child: Container(
                                  child: _isAgreeCheckBox
                                      ? Container(
                                      height: 20,
                                      width: 20,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        child: Container(
                                          color: MyAppTheme.pin_bg_Color,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image.asset(
                                                MyImages.ic_checked,
                                                height: 12,
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      ))
                                      : Container(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Image.asset(MyImages.ic_unchecked,
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.fill),
                                  ),
                                )),
                            SizedBox(
                              width: screenSize.height * 0.01,
                            ),
                              LightTextBodyFuturaPTBook17(data: 'dontAsk'.tr),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        CustomButton(
                          'submit'.tr,
                          54,
                          onPressed: () {
                            if (verification_formKey.currentState!.validate()) {
                              FocusScope.of(this.context)
                                  .requestFocus(FocusNode());
                              Helpers.verifyInternet().then((intenet) {
                                if (intenet != null && intenet) {
                                  createVerifyUserEmailOtp(
                                          _pinPutController.text,email, context)
                                      .then((response) {
                                    setState(() {
                                      if (response.status == true) {
                                        // Get.toNamed(MyRouter.createProfile);
                                        // Navigator.pushReplacementNamed(context, MyRouter.createProfile);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CreateProfile(email, password)),
                                        );
                                      } else {
                                        //  Get.toNamed(MyRouter.createProfile);
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
                    LightTextBodyFuturaPTBook13(
                    data: 'dontReceive'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  ResendOtpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RichText ResendOtpButton() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: MyAppTheme.textPrimary,
              fontFamily: Fonts.futurPT,
              fontWeight: FontWeight.w100,),
            children: <TextSpan>[

              _start==0 ?   TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  //  otpTextCtrl.clear();
                    if(mounted)
                    {
                      setState(() {
                        _start = 29;
                        startTimer();
                      });
                    }
                    _reSendCodePopUp(context, 'sendOTP'.tr, 'otpSendTo'.tr +' '+ widget.email.toString(), 'ok'.tr);
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: MyAppTheme.textPrimary,
                  fontFamily: Fonts.futurPT,
                  fontWeight: FontWeight.w100,),
                text: 'resendCode'.tr,
              ) :  TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {},
                style:  const TextStyle(
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: MyAppTheme.textPrimary,
                  fontFamily: Fonts.futurPT,
                  fontWeight: FontWeight.w100,),
                text: 'resendCode'.tr,
              ),
              _start==0 ? TextSpan(text:'') : TextSpan(text: ' in ''$_start sec'),
            ]));
  }

  _reSendCodePopUp(BuildContext context, String title , String dis , String action ) {
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

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  const SizedBox(height: 15,),
                  LightTextBodyFuturaPTHeavy28(data: title,),

                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                      LightTextBodyFuturaPTLight15(data: dis ,)

                  ),
                  const SizedBox(height: 20,),
                  const Divider(),

                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Helpers.verifyInternet().then((intenet) {
                          if (intenet != null && intenet) {
                            createResendOtp(otpType, email, context).then((response) {
                              setState(() {
                                if (response.status == true) {

                                }
                              });
                            });
                          } else {
                            Helpers.createSnackBar(
                                context, "Please check your internet connection");
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: LightTextBodyFuturaPTBold18(data: action,),
                      )),
                ],),
              )
          );
        });
  }
}
