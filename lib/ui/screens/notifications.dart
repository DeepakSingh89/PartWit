import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/NotificationProvider.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => {getNotificationList(context)});
        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: Utility.actionBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: LightTextBodyFuturaPTMedium20(
                data: 'notifications'.tr,
              ),
            ),
            Expanded(child: Consumer<NotificationProvider>(
                builder: (BuildContext context, modal, Widget? child) {
              return modal.loading
                  ? modal.notificationData.data != null &&
                          modal.notificationData.data!.notifications!.isNotEmpty
                      ? ListView.builder(
                          itemCount: modal
                              .notificationData.data!.notifications!.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              MyAppTheme.backgroundColor,
                                          radius: 30,
                                          child: Image.asset(
                                            MyImages.ic_app_logo,
                                            fit: BoxFit.cover,
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.02,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 2),
                                            child: SizedBox(
                                              height: screenSize.height * 0.07,
                                              width: screenSize.width * 0.5,
                                              child: Text(
                                                modal
                                                    .notificationData
                                                    .data!
                                                    .notifications![index]
                                                    .description!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15,
                                                  color: MyAppTheme.textPrimary,
                                                  fontFamily: Fonts.futurPT,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenSize.width * 0.03,
                                      ),
                                      Flexible(
                                        child: LightTextBodyFuturaPTBook12(
                                          data: Utility.readTimestamp(modal
                                              .notificationData
                                              .data!
                                              .notifications![index]
                                              .createdAt!), //Constant.LOREM1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 2,

                                ),
                              ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: LightTextBodyFuturaPTHeavy18(
                                    data: 'noRecord'.tr)),
                          ],
                        )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: LightTextBodyFuturaPTHeavy18(data: ''));
            })),
          ],
        ),
      ),
    );
  }

  getNotificationList(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false).loading = false;

    Provider.of<NotificationProvider>(context, listen: false)
        .notificationList(context);
  }
}
