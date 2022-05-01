import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyWhiteFuturaPTBook13 extends StatelessWidget {
  final String data;
  const LightTextBodyWhiteFuturaPTBook13({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 16,
          color: MyAppTheme.whiteColor,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w500,),
      ),
    );
  }
}
