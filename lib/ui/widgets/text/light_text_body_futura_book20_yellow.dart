import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class LightTextBodyYellowFuturaPTBook20 extends StatelessWidget {
  final String data;
  const LightTextBodyYellowFuturaPTBook20({required this.data}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        data,
        style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 20,
          color: MyAppTheme.chatTextColor,
          fontFamily: Fonts.futurPT,
          fontWeight: FontWeight.w100,),
      ),
    );
  }
}
