import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyGreenFuturaPTMedium16 extends StatelessWidget {
  final String data;
  const LightTextBodyGreenFuturaPTMedium16({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 15,
          color: MyAppTheme.greenColor,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w500,),
      ),
    );
  }
}
