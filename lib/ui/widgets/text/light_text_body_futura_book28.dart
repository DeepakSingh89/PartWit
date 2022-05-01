import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyFuturaPTBook28 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTBook28({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 28,
          color: MyAppTheme.textPrimary,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w100,),
      ),
    );
  }
}
