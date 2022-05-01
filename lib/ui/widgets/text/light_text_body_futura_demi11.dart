import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyFuturaPTDemi11 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTDemi11({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 11,
          color: MyAppTheme.textPrimary,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w200,),
      ),
    );
  }
}
