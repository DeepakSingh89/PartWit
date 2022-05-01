import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyFuturaPTMediumBlack24 extends StatelessWidget {
  final String data;
  const LightTextBodyFuturaPTMediumBlack24({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 24,
          color: MyAppTheme.black_Color,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w500,),
      ),
    );
  }
}
