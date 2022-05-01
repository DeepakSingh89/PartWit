import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:part_wit/repository/forgot_password_repository.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/verification_forget_password_screen.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_underline_futura_heavy14.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyAppTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          ///hide keyboard function
          Utility.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: MyAppTheme.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: forgotKey,
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.10,
                  ),
                  Center(
                    child: Image.asset(MyImages.ic_app_logo),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                    LightTextBodyFuturaPTHeavy34(
                    data: 'forgotPsw'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                    LightTextBodyFuturaPTBook16(data: 'email_text'.tr),
                    LightTextBodyFuturaPTBook16(data: 'email_text_'.tr),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 60, 40, 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: MyAppTheme.textPrimary,
                          fontFamily: Fonts.futurPT,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                      obscureText: false,
                      focusNode: emailFocus,
                      controller: _emailController,
                      onTap: () {
                        setState(() {
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email address';
                        } else if (!isEmail(_emailController.text)) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: MyAppTheme.buttonShadow_Color,
                        hintText: 'email'.tr,
                        hintStyle: const TextStyle(
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                        prefixIcon: Image.asset(MyImages.ic_mail),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MyAppTheme.buttonShadow_Color),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: MyAppTheme.buttonShadow_Color),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0))),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: MyAppTheme.whiteColor, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        CustomButton(
                          'submit'.tr,
                          54,
                          onPressed: () {
                            if (forgotKey.currentState!.validate()) {
                              FocusScope.of(this.context).requestFocus(FocusNode());
                              Helpers.verifyInternet().then((internet) {
                                if (internet) {
                                  createForgotPassword(_emailController.text,context)
                                      .then((response) {
                                    setState(() {
                                      if(response.status==true){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => VerificationForgetPasswordScreen(_emailController.text,Constant.FORGET_PASSWORD)),
                                        );
                                        /*Map<String, String> map = {
                                          "email": _emailController.text,
                                          "type": Constant.FORGET_PASSWORD,
                                        };
                                        Get.toNamed(MyRouter.verificationScreen,
                                            parameters: map);*/
                                      }
                                    });
                                  });
                                } else {
                                  Helpers.createSnackBar(context, "Please check your internet connection");
                                }
                              });

                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.09,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        LightTextBodyFuturaPTBook14(data: 'dontHave'.tr),
                      SizedBox(
                        width: screenSize.height * 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(MyRouter.signupScreen);
                        },
                        child:    LightTextBodyUnderLineFuturaPTHeavy14(
                          data: 'signUpHere'.tr,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}
