import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12_white.dart';

class CustomCircle extends StatelessWidget {
  final String data;

  const CustomCircle( {required this.data, required Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      child: MaterialButton(
        minWidth: screenSize.width * 0.03,
        height: screenSize.height * 0.03,
        elevation: 0.0,
        onPressed: () {},
        color: MyAppTheme.circleColor,
        textColor: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: LightTextBodyWhiteFuturaPTBook12(
              data: data,
            )),
        shape: const CircleBorder(),
      ),
    );
  }
}
