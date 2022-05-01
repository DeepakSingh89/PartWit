import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/PrivacyPolicyProvider.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';

class Privacypolicy extends StatefulWidget {
  const Privacypolicy({Key? key}) : super(key: key);

  @override
  _PrivacypolicyState createState() => _PrivacypolicyState();
}

class _PrivacypolicyState extends State<Privacypolicy> {

  @override
  void initState() {
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {privacyPolicy( context)});


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
    return Scaffold(
        appBar: Utility.actionBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15.0, right: 20.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:   [
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<PrivacyPolicyProvider>(
                        builder: (BuildContext context, modal, Widget? child) {
                          return modal.loading
                              ? modal.privacyPolicy.data != null
                              ? Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              LightTextBodyFuturaPTBook23(
                                  data: modal.privacyPolicy.data!.title!),
                              const SizedBox(
                                height: 16,
                              ),

                              Html(data:modal.privacyPolicy.data!
                                  .description!),
                              // LightTextBodyFuturaPTMedium16(
                              //     data: modal.privacyPolicy.data!
                              //         .description != null
                              //         ? modal.privacyPolicy.data!
                              //         .description!
                              //         .replaceFirst("<p>", "")
                              //         .replaceAll("</p>", "")
                              //         .toString()
                              //         : 'noRecord'.tr),

                            ],
                          ): const SizedBox()
                              : Container();
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  privacyPolicy(BuildContext context) {
    Provider.of<PrivacyPolicyProvider>(context, listen: false).loading = false;
    Provider.of<PrivacyPolicyProvider>(context, listen: false).privacyPolicyData(context);
  }
}
