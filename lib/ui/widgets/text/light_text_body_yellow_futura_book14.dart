import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyYellowUnderlineFuturaPTBook14 extends StatelessWidget {
  final String data;
  const LightTextBodyYellowUnderlineFuturaPTBook14({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: MyAppTheme.backgroundColor,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w100,),
      ),
    );
  }
}
