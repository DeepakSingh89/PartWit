import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyFuturaPTHeavy34 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTHeavy34({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 34,
        color: MyAppTheme.textPrimary,
        fontFamily: Fonts.futurPT,
        fontWeight: FontWeight.w400,),
    );
  }
}
