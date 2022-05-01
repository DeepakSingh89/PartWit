import 'package:flutter/material.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/AboutPartWitProvider.dart';
import 'package:part_wit/provider/WelecomPartwitProvider.dart';

import 'package:part_wit/ui/screens/home_screen.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/custom_widgets/common_widget.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';


class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
  final welcomeFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {wlcmPartWit( context)});


        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: MyAppTheme.backgroundColor,
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.15,
          ),
          Center(
            child: Image.asset(MyImages.ic_app_logo),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),




          Consumer<WelcomePartWitProvider>(
              builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.wlcm.data != null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    LightTextBodyFuturaPTHeavy34(
                        data: modal.wlcm.data!.title!),
                    addHeight(
                      screenSize.height * 0.05,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25,),
                      child:

                      Html(data:modal.wlcm.data!
                          .description!),


                    ),

                  ],
                ): const SizedBox()
                    : Container();
              }),

          SizedBox(
            height: screenSize.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                CustomButton(
                  'continue'.tr,
                  54,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(0)),
                        ModalRoute.withName("/HomeScreen"));
                    // Navigator.pushReplacementNamed(context, MyRouter.homeScreen);
                    // Get.toNamed(MyRouter.homeScreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }

  wlcmPartWit(BuildContext context) {
    Provider.of<WelcomePartWitProvider>(context, listen: false).loading = false;
    Provider.of<WelcomePartWitProvider>(context, listen: false).wlcmData(context);
  }
}