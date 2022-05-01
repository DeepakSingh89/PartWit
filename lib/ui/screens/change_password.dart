import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/repository/verify_reset_password.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/custom_widgets/common_widget.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/utils/Helpers.dart';

import 'package:part_wit/utils/utility.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passFormKey = GlobalKey<FormState>();
  final oldPassFormKey = GlobalKey<FormState>();
  final newPassFormKey = GlobalKey<FormState>();
  bool _showOldPassword = false,
      _showNewPassword = false,
      _showConfirmPassword = false;
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _confrimpasswordController =
  TextEditingController();

  FocusNode newpassWordFocus = FocusNode();
  FocusNode oldPassWordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

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
    final screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
        child: GestureDetector(
        onTap: ()
    {
      Utility.hideKeyboard(context);
    },
    child: Scaffold(
    appBar: Utility.actionBar(),
    body: SingleChildScrollView(
    child: Form(
    key: passFormKey,
    child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    SizedBox(
    height: screenSize.height * 0.05,
    ),
    LightTextBodyFuturaPTBook23(
    data: 'changePsw'.tr,
    ),
    SizedBox(
    height: screenSize.height * 0.02,
    ),
    Form(
    key: oldPassFormKey,
    child: TextFormField(
    style: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    maxLength: 15,
    controller: _oldController,
    obscureText: !_showOldPassword,
    focusNode: oldPassWordFocus,
    onTap: () {

    textCurrentState(1);

    setState(() {});
    },
    validator: (value) {
    return passwordValidation(value);
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(

    counterText: "",
    errorMaxLines: 2,

    suffixIconConstraints: const BoxConstraints(
    minHeight: 24, minWidth: 24),
    filled: true,
    fillColor: MyAppTheme.txtShadow_Color,
    hintText: 'currentPsw'.tr,
    hintStyle: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color),
    borderRadius: BorderRadius.circular(15.0),
    ),
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
    color: MyAppTheme.txtShadow_Color),
    borderRadius:
    BorderRadius.all(Radius.circular(15.0))),
    border: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color,
    width: 2.0),
    borderRadius: BorderRadius.circular(15.0)),

    suffixIcon: IconButton(
    icon: _showOldPassword
    ? const ImageIcon(
    AssetImage(MyImages.ic_eye_open),
    color: MyAppTheme.passwordIconColor,
    )
        : const ImageIcon(
    AssetImage(MyImages.ic_eye_close),
    color: MyAppTheme.passwordIconColor,
    ),
    onPressed: () {
    setState(
    () => _showOldPassword = !_showOldPassword);
    },
    ),

    // IconButton(
    //   icon: _showOldPassword
    //       ? const ImageIcon(AssetImage(MyImages.ic_eye_open))
    //       : const ImageIcon(AssetImage(MyImages.ic_eye_close)),
    //   onPressed: () {
    //     setState(() => _showOldPassword = !_showOldPassword);
    //   },
    // ),
    ),
    )),
    SizedBox(
    height: screenSize.height * 0.02,
    ),
    Form(
    key: newPassFormKey,
    child: TextFormField(
    style: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    controller: _newpasswordController,
    obscureText: !_showNewPassword,
    focusNode: newpassWordFocus,
    maxLength: 15,
    onTap: () {
    textCurrentState(2);
    setState(() {});
    },
    validator: (value) {
    return newPasswordValidation(value);
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
    counterText: "",
    errorMaxLines: 2,
    suffixIconConstraints:
    const BoxConstraints(minHeight: 24, minWidth: 24),
    filled: true,
    fillColor: MyAppTheme.txtShadow_Color,
    hintText: 'newPassword'.tr,
    hintStyle: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color),
    borderRadius: BorderRadius.circular(15.0),
    ),
    enabledBorder: const OutlineInputBorder(
    borderSide:
    BorderSide(color: MyAppTheme.txtShadow_Color),
    borderRadius:
    BorderRadius.all(Radius.circular(15.0))),
    border: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color,
    width: 2.0),
    borderRadius: BorderRadius.circular(15.0)),
    suffixIcon: IconButton(
    icon: _showNewPassword
    ? const ImageIcon(
    AssetImage(MyImages.ic_eye_open),
    color: MyAppTheme.passwordIconColor,
    )
        : const ImageIcon(
    AssetImage(MyImages.ic_eye_close),
    color: MyAppTheme.passwordIconColor,
    ),
    onPressed: () {
    setState(
    () => _showNewPassword = !_showNewPassword);
    },
    ),
    ),
    ),
    ),
    SizedBox(
    height: screenSize.height * 0.02,
    ),
    TextFormField(
    style: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    controller: _confrimpasswordController,
    obscureText: !_showConfirmPassword,
    focusNode: confirmPasswordFocus,
    maxLength: 15,
    onTap: () {
    textCurrentState(3);
    setState(() {});
    },
    validator: (value) {
    return newConfirmPasswordValidation(value);
    },
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
    counterText: "",
    errorMaxLines: 2,
    suffixIconConstraints:
    const BoxConstraints(minHeight: 44, minWidth: 44),
    filled: true,
    fillColor: MyAppTheme.txtShadow_Color,
    hintText: 'confirmNewPassword'.tr,
    hintStyle: const TextStyle(
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: MyAppTheme.textPrimary,
    fontFamily: Fonts.futurPT,
    fontWeight: FontWeight.w100,
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color),
    borderRadius: BorderRadius.circular(15.0),
    ),
    enabledBorder: const OutlineInputBorder(
    borderSide:
    BorderSide(color: MyAppTheme.txtShadow_Color),
    borderRadius:
    BorderRadius.all(Radius.circular(15.0))),
    border: OutlineInputBorder(
    borderSide: const BorderSide(
    color: MyAppTheme.txtShadow_Color, width: 2.0),
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
    'update'.tr,
    54,
    onPressed: () {
    if (oldPassFormKey.currentState!.validate()) {
    if (newPassFormKey.currentState!.validate()) {
    if (passFormKey.currentState!.validate()) {
    FocusScope.of(this.context)
        .requestFocus(FocusNode());

    if (_newpasswordController.text ==
    _confrimpasswordController.text) {
    createOldPassword(
    _oldController.text,
    _newpasswordController.text,
    _confrimpasswordController.text,
    context)
        .then((response) {
    setState(() {
    if (response.status == true) {
    Navigator.pop(context);
    }
    });
    });
    } else {
    Helpers.createSnackBar(context,
    "Your password doesn't match");
    }
    }
    }
    }
  }

  ,
  ),
  ],
  ),
  ),
  ],
  ),
  ),
  ),
  ),
  ),
  )

  ,

  );
}

void textCurrentState(int no) {
  if (no == 1) {
    if (oldPassFormKey.currentState!.validate()) {
      if (newPassFormKey.currentState!.validate()) {
        if (passFormKey.currentState!.validate()) {
          FocusScope.of(context)
              .requestFocus(oldPassWordFocus);
        }
      }
    }
  }
  if (no == 2) {
    if (oldPassFormKey.currentState!.validate()) {
      if (newPassFormKey.currentState!.validate()) {
        if (passFormKey.currentState!.validate()) {
          FocusScope.of(context)
              .requestFocus(newpassWordFocus);
        }
      }
    }
  }
  if (no == 3) {
    if (oldPassFormKey.currentState!.validate()) {
      if (newPassFormKey.currentState!.validate()) {
        if (passFormKey.currentState!.validate()) {
          FocusScope.of(context)
              .requestFocus(confirmPasswordFocus);
        }
      }
    }
  }
}}
