import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyFuturaPTLight15 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTLight15({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 15,
          color: MyAppTheme.textPrimary,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w400,),
      ),
    );
  }
}
