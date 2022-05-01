import 'package:flutter/material.dart';

class MyAppTheme {
  MyAppTheme._();




  static const backgroundColor = Color(0xFFFED001);
  static const failRed = Color(0xFFF31B32);

  static const buttonColor = Color(0xFFFFDC3B);
  static const circleColor = Color(0xFFFEDC40);
  static const chatTextColor = Color(0xFFB79600);

  static const textPrimary = Color(0xFF474747);
  static const textPrimary_ = Color(0xFF989898);
  static const whiteColor = Color(0xFFFFFFFF);
  static const buttonShadow_Color = Color(0xFFFFE572);
  static const passwordIconColor = Color(0xFF474747);
  static const pin_bg_Color = Color(0xFFF7DB5F);
  static const black_Color = Color(0xFF000000);
  static const border_Color = Color(0xFF000000);

  static const items_bg_Color = Color(0xFFF5F5F5);
  static const plan_bg_Color = Color(0xFFFF5F5F5);
  static const textfield_bg_grayColor = Color(0xFFF2F2EF);
  static const txtShadow_Color = Color(0xFFf2f3ee);
  static const dividerColor = Color(0xFFE0E0E0);

  //plan box colors
  static const box_bg_grayColor = Color(0xFFD5D5D5);
  static const greenColor = Color(0xFF00A81A);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
   // splashColor: primaryColor,
    brightness: Brightness.light,
    //textTheme: lightTextTheme,
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: _title,
    subtitle1: _subTitleLight,
    //bodyText1: _greetingLight,
  );

  static final TextStyle _title = TextStyle(
    color: textPrimary,
    fontSize: 3.5,
    //fontSize: 3.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _subTitleLight = TextStyle(
    color: textPrimary,
    fontSize: 2,
    //fontSize: 2 * SizeConfig.textMultiplier,
  );
/*
  static final TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 2.5 * SizeConfig.textMultiplier,
  );

  static final TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 2.0 * SizeConfig.textMultiplier,
  );

  static final TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 2.3 * SizeConfig.textMultiplier,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  //static final TextStyle _subTitleDark = _subTitleLight.copyWith(color: Colors.white70);

  static final TextStyle _buttonDark = _buttonLight.copyWith(color: Colors.black);

  static final TextStyle _greetingDark = _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark = _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark = _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark = _selectedTabDark.copyWith(color: Colors.white70);*/
}
