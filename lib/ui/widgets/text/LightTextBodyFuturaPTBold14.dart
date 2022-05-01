import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';

class LightTextBodyFuturaPTBold14 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTBold14({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 16,
        color: MyAppTheme.textPrimary,
        fontFamily: Fonts.futurPT,
        fontWeight: FontWeight.w600,),
    );
  }
}
