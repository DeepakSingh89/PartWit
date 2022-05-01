import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';


class LightTextBodyWhiteFuturaPTBook12 extends StatelessWidget {
  final String data;
  const LightTextBodyWhiteFuturaPTBook12({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 12,
            color: MyAppTheme.whiteColor,
            fontFamily: Fonts.futurPT,
            fontWeight: FontWeight.w100,),
        ),
      ),
    );
  }
}
