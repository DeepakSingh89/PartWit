import 'dart:io' show Platform;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/CommonResponse.dart';
import 'package:part_wit/repository/send_register_otp.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/login_screen.dart';
import 'package:part_wit/ui/screens/verification_screen.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_underline_futura_heavy14.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

CommonResponse? model;

class _SignUpScreenState extends State<SignUpScreen> {
  final signupFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  bool _showPassword = false,
      _showConfirmPassword = false,
      _isPasswordFocus = false,
      _isEmailFocus = false,
      _isConfirmPasswordFocus = false,
      _isAgreeCheckBox = true;
  bool isIOS = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode passWordFocus = FocusNode();
  FocusNode confirmPassWordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  GoogleSignInAccount? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '740034809617-kpifjtk2mvnch6i6c92g9tnpr6ljekp3.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  initState() {
    setState(() {
      checkPlatform();
      emailValidCon();
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        setState(() {
          _currentUser = account;
          print("GOOGLE1" + _currentUser!.email.toString());
        });
      });
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyAppTheme.backgroundColor),
    );
  }

  void emailValidCon() {
    _emailController.addListener(() {
      if (isEmail(_emailController.text)) {
        emailFormKey.currentState!.validate();
      }
    });

    _passwordController.addListener(() {
      if (validatePassword(_passwordController.text)) {
        passwordFormKey.currentState!.validate();
      }
    });
    _confirmPasswordController.addListener(() {
      if (validatePassword(_confirmPasswordController.text)) {
        signupFormKey.currentState!.validate();
      }
    });
  }

  void checkPlatform() {
    if (Platform.isAndroid) {
      isIOS = false;
    } else if (Platform.isIOS) {
      isIOS = true;
    }
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

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
              key: signupFormKey,
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
                    data: 'signUp'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Form(
                    key: emailFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        ],
                        style: const TextStyle(
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                        obscureText: false,
                        focusNode: emailFocus,
                        controller: _emailController,
                        onTap: () {
                          textCurrentState(1);
                          setState(() {
                            _isEmailFocus = true;
                            _isPasswordFocus = false;
                            _isConfirmPasswordFocus = false;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
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
                          errorMaxLines: 2,
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
                              borderSide: BorderSide(
                                  color: MyAppTheme.buttonShadow_Color),
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
                  Form(
                    key: passwordFormKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp('[ ]')),
                          LengthLimitingTextInputFormatter(15),
                        ],
                        style: const TextStyle(
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                        controller: _passwordController,
                        obscureText: !this._showPassword,
                        focusNode: passWordFocus,
                        maxLength: 15,

                        onTap: () {
                          textCurrentState(2);
                          setState(() {
                            _isConfirmPasswordFocus = false;
                            _isPasswordFocus = true;
                            _isEmailFocus = false;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 8) {
                            return 'Password should be alphanumeric and greater than 8';
                          //  return 'Password should greater than 8 & also contains upper/lower/special char & number';
                            // return 'Password must be greater than 8';
                          }

                          // else if (!validatePassword(value)) {
                          //   return 'Password must be a combination of upper and lower with special char and number';
                          // }

                          else if (value.length > 15) {
                            return 'Password must be less then 16';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          counterText: "",
                          suffixIconConstraints:
                              const BoxConstraints(minHeight: 24, minWidth: 24),
                          filled: true,
                          errorMaxLines: 2,
                          fillColor: MyAppTheme.buttonShadow_Color,
                          hintText: 'password'.tr,
                          hintStyle: const TextStyle(


                              color: MyAppTheme.textPrimary,
                              fontFamily: Fonts.futurPT,
                              fontWeight: FontWeight.w100,
                              fontSize: 16),
                          prefixIcon:Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child:  Image.asset(MyImages.ic_padlock),
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
                          suffixIcon: IconButton(
                            icon: _showPassword
                                ? const ImageIcon(
                                    AssetImage(MyImages.ic_eye_open),
                                    color: MyAppTheme.passwordIconColor,
                                  )
                                : const ImageIcon(
                                    AssetImage(MyImages.ic_eye_close),
                                    color: MyAppTheme.passwordIconColor,
                                  ),
                            onPressed: () {
                              setState(() => _showPassword = !_showPassword);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        LengthLimitingTextInputFormatter(15),
                      ],

                      style: const TextStyle(
                          color: MyAppTheme.textPrimary,
                          fontFamily: Fonts.futurPT,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                      controller: _confirmPasswordController,
                      obscureText: !this._showConfirmPassword,
                      focusNode: confirmPassWordFocus,
                      maxLength: 15,
                      onTap: () {
                        textCurrentState(3);
                        setState(() {
                          _isConfirmPasswordFocus = true;
                          _isPasswordFocus = false;
                          _isEmailFocus = false;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter confirm password';
                        } else if (value.length < 8) {
                          return 'Password should be alphanumeric and greater than 8';
                          //return 'Password should greater than 8 & also contains upper/lower/special char & number';
                        }
                        // else if (!validatePassword(value)) {
                        //   return 'Password must be a combination of upper and lower with special char and number';
                        // }
                        else if (value.length > 15) {
                          return 'Password must be less then 16';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        counterText: "",
                        suffixIconConstraints:
                            const BoxConstraints(minHeight: 44, minWidth: 44),
                        filled: true,
                        errorMaxLines: 2,
                        fillColor: MyAppTheme.buttonShadow_Color,
                        hintText: 'confirmPsw'.tr,
                        hintStyle: const TextStyle(
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child:  Image.asset(MyImages.ic_padlock),
                        ),
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
                                color: MyAppTheme.buttonShadow_Color, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0)),
                        suffixIcon: IconButton(
                          icon: _showConfirmPassword
                              ? const ImageIcon(
                                  AssetImage(MyImages.ic_eye_open),
                                  color: MyAppTheme.passwordIconColor,
                                )
                              : const ImageIcon(
                                  AssetImage(MyImages.ic_eye_close),
                                  color: MyAppTheme.passwordIconColor,
                                ),
                          onPressed: () {
                            setState(() =>
                                _showConfirmPassword = !_showConfirmPassword);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 0),
                    child: Row(
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
                        const SizedBox(
                          width: 15,
                        ),
                        getAgreeTermsConditions(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        CustomButton(
                          'register'.tr,
                          54,
                          onPressed: () {
                            // Helpers.createSnackBar(
                            //     context, _isAgreeCheckBox.toString());
                            if (emailFormKey.currentState!.validate()) {
                              if (passwordFormKey.currentState!.validate()) {
                                if (!signupFormKey.currentState!.validate()) {
                                } else if (!_isAgreeCheckBox) {
                                  Helpers.createSnackBar(context,
                                      "Please accept Terms & Conditions");
                                } else {
                                  _isConfirmPasswordFocus = false;
                                  _isPasswordFocus = false;
                                  _isEmailFocus = false;
                                  FocusScope.of(this.context)
                                      .requestFocus(FocusNode());
                                  Helpers.verifyInternet().then((intenet) {
                                    if (intenet) {
                                      if (_passwordController.text ==
                                          _confirmPasswordController.text) {
                                        sendRegisterOtp(
                                                _emailController.text, context)
                                            .then((response) {
                                          setState(() {
                                            model = response;
                                            if (model!.status) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerificationScreen(
                                                            _emailController.text,
                                                            _passwordController
                                                                .text,
                                                            Constant
                                                                .REGISTRATION_OTP)),
                                              );
                                            }
                                          });
                                        });
                                      } else {
                                        Helpers.createSnackBar(context,
                                            "Your Password Doesn't Match");
                                      }
                                    } else {
                                      Helpers.createSnackBar(context,
                                          "Please check your internet connection");
                                    }
                                  });
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                    LightTextBodyFuturaPTBook15(data: 'social_media_text'.tr),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  socialMedialSignIn(screenSize),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        LightTextBodyFuturaPTBook14(data: 'already_an_acc'.tr),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              ModalRoute.withName("/LoginScreen"));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 6, 6, 6),
                          child: LightTextBodyUnderLineFuturaPTHeavy14(
                            data: 'signIn'.tr,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Flexible getAgreeTermsConditions() {
    return Flexible(
        child: RichText(
            text: TextSpan(
                text: 'agree'.tr,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: MyAppTheme.textPrimary,
                  fontFamily: Fonts.futurPT,
                  fontWeight: FontWeight.w100,),
                children: [
          TextSpan(
              text: 'terms'.tr,
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.toNamed(MyRouter.termscondition),
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: MyAppTheme.textPrimary,
                fontFamily: Fonts.futurPT,
                fontWeight: FontWeight.w100,
              )),
            TextSpan(text: 'and'.tr, style: const TextStyle()),
          TextSpan(
              text: 'policy'.tr,
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.toNamed(MyRouter.privacypolicy),
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                color: MyAppTheme.textPrimary,
                fontFamily: Fonts.futurPT,
                fontWeight: FontWeight.w100,
              )),
        ])));
  }

  Row socialMedialSignIn(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            FacebookAuth.instance
                .login(permissions: ["public_profile", "email"]).then((value) {
              print("FB DATA :: " +
                  value.toString() +
                  "\n" +
                  value.status.toString());
              print("FB DATA 1 :: " + value.accessToken.toString());
              FacebookAuth.instance.getUserData().then((userData) {
                setState(() {
                  // _isLoggedIn = true;
                  // _userObj = userData;
                  // print("USER DATA :: " + _userObj.toString());
                });
              });
            });
          },
          child: Image.asset(
            MyImages.ic_fb,
          ),
        ),
        SizedBox(
          width: screenSize.height * 0.02,
        ),
        GestureDetector(
          onTap: () {
            _handleSignIn();
            print("USER :: " + _currentUser!.email);
          }, // handle your image tap here
          child: Image.asset(
            MyImages.ic_gplus,
          ),
        ),
        Visibility(
          child: Row(
            children: [
              SizedBox(
                width: screenSize.height * 0.02,
              ),
              GestureDetector(
                child: Image.asset(
                  MyImages.ic_mac,
                ),
                onTap: () {},
              ),
            ],
          ),
          visible: isIOS,
        ),
      ],
    );
  }

  void textCurrentState(int no) {
    if(no==1)
    {
      if (emailFormKey.currentState!.validate()) {
        if (passwordFormKey.currentState!.validate()) {
          if (signupFormKey.currentState!.validate()) {
            FocusScope.of(context)
                .requestFocus(emailFocus);
          }
        }
      }
    }
    if(no==2){
      if (emailFormKey.currentState!.validate()) {
        if (passwordFormKey.currentState!.validate()) {
          if (signupFormKey.currentState!.validate()) {
            FocusScope.of(context)
                .requestFocus(passWordFocus);
          }
        }
      }
    }
    if(no==3){
      if (emailFormKey.currentState!.validate()) {
        if (passwordFormKey.currentState!.validate()) {
          if (signupFormKey.currentState!.validate()) {
            FocusScope.of(context)
                .requestFocus(confirmPassWordFocus);
          }
        }
      }
    }


  }
}

bool isEmail(String em) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(em);
}

bool validatePassword(String value) {
  return RegExp(r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(value);
}
