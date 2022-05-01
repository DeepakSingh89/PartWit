import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/TermsConditionsProvider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/utils/Helpers.dart';

import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  _TermsConditionState createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {

  @override
  void initState() {
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {termsConditons( context)});


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
    return
          SafeArea(
            child: Scaffold(
              appBar: Utility.actionBar(),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 15.0, right: 20.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
    Consumer<TermsConditionProvider>(
    builder: (BuildContext context, modal, Widget? child) {
      return modal.loading
          ? modal.termAndConditionData.data != null
          ? Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          LightTextBodyFuturaPTBook23(
              data: modal.termAndConditionData.data!.title!),
          const SizedBox(
            height: 16,
          ),

          Html(data:modal.termAndConditionData.data!
              .description!),

        ],
      ): const SizedBox()
          : Container();
    }),

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ) ;

        }
   // );
  }

  termsConditons(BuildContext context) {

  Provider.of<TermsConditionProvider>(context, listen: false).loading = false;
    Provider.of<TermsConditionProvider>(context, listen: false).termsCondtions(context);
  }

