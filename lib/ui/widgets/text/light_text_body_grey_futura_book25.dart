import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyGreyFuturaPTBook25 extends StatelessWidget {
  final String data;
  const LightTextBodyGreyFuturaPTBook25({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 25,
          color: MyAppTheme.textPrimary_,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w100,),
      ),
    );
  }
}
