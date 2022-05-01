import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/AboutPartWitProvider.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_widgets/common_widget.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class AboutPartWit extends StatefulWidget {
  const AboutPartWit({Key? key}) : super(key: key);

  @override
  _AboutPartWitState createState() => _AboutPartWitState();
}

class _AboutPartWitState extends State<AboutPartWit> {

  @override
  void initState() {
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {aboutPartWit( context)});


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
    return SafeArea(
      child: Scaffold(

        backgroundColor: MyAppTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              addHeight(screenSize.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () => {Get.back()}),
                ],
              ),
              Center(
                child: Image.asset(MyImages.ic_app_logo),
              ),
              addHeight(
                screenSize.height * 0.03,
              ),

              Consumer<AboutPartWitProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                    return modal.loading
                        ? modal.aboutUs.data != null
                        ? Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        LightTextBodyFuturaPTHeavy34(
                            data: modal.aboutUs.data!.title!),
                        addHeight(
                          screenSize.height * 0.05,
                        ),

                          Padding(
                          padding: const EdgeInsets.only(left: 25,right: 25,),
                          child:

                          Html(data:modal.aboutUs.data!
                        .description!),


                        ),

                      ],
                    ): const SizedBox()
                        : Container();
                  }),



              addHeight(
                screenSize.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

aboutPartWit(BuildContext context) {
  Provider.of<AboutPartWitProvider>(context, listen: false).loading = false;
  Provider.of<AboutPartWitProvider>(context, listen: false).AboutPartWitData(context);
}
