import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_wit/ui/screens/signup_screen.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

import 'package:part_wit/ui/styles/my_images.dart';

SizedBox addHeight(double size) => SizedBox(height: size);

ImageIcon passwordIcon(_showConfirmPassword) {
  return _showConfirmPassword
      ? const ImageIcon(
          AssetImage(MyImages.ic_eye_open),
          color: MyAppTheme.passwordIconColor,
        )
      : const ImageIcon(
          AssetImage(MyImages.ic_eye_close),
          color: MyAppTheme.passwordIconColor,
        );
}

String? passwordValidation(String? value) {
  if (value!.isEmpty) {
    return 'Please enter password';
  } else if (value.length < 8) {
    return 'Password must be greater then 8';
  } else if (!validatePassword(value)) {
    return 'Password must be a combination of upper and lower with special char and number';
  } else if (value.length > 16) {
    return 'Password must be less then 16';
  }
  return null;
}

String? newPasswordValidation(String? value) {
  if (value!.isEmpty) {
    return 'Please enter new password';
  } else if (value.length < 8) {
    return 'Password must be greater then 8';
  } else if (!validatePassword(value)) {
    return 'Password must be a combination of upper and lower with special char and number';
  } else if (value.length > 16) {
    return 'Password must be less then 16';
  }
  return null;
}

String? newConfirmPasswordValidation(String? value) {
  if (value!.isEmpty) {
    return 'Please Confirm new password';
  } else if (value.length < 8) {
    return 'Password must be greater then 8';
  } else if (!validatePassword(value)) {
    return 'Password must be a combination of upper and lower with special char and number';
  } else if (value.length > 16) {
    return 'Password must be less then 16';
  }
  return null;
}
