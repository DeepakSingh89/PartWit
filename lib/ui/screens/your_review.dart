import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/SellerReviewsProvider.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';

class YourReview extends StatefulWidget {
  const YourReview({Key? key}) : super(key: key);

  @override
  State<YourReview> createState() => _YourReviewState();
}

class _YourReviewState extends State<YourReview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
              (_) => {_getReviews(Constant.YOURS_REVIEWS, context)});
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
        appBar: AppBar(
          backgroundColor: MyAppTheme.backgroundColor,
          brightness: Brightness.dark,
          centerTitle: true,
          title: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: Image.asset(MyImages.ic_app_logo),
          ),
          leading: Builder(
            builder: (context) => FlatButton(
                padding: const EdgeInsets.all(0.0),
                child: const Icon(Icons.arrow_back),
                onPressed: () => {Get.back()}),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: LightTextBodyFuturaPTMedium20(
                data: 'yourReview'.tr,
              ),
            ),
            Consumer<SellerReviewProvider>(
                builder: (BuildContext context, modal, Widget? child) {
              return modal.loading
                  ? modal.sellerRevieviws.data != null &&
                          modal.sellerRevieviws.data!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: modal.sellerRevieviws.data!.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 1),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 10),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                    color: MyAppTheme
                                                        .items_bg_Color,
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.grey,
                                                                radius: 35,
                                                                child: modal.sellerRevieviws.data![index].userProfilePic! !=
                                                                            null &&
                                                                        modal
                                                                            .sellerRevieviws
                                                                            .data![
                                                                                index]
                                                                            .userProfilePic!
                                                                            .isNotEmpty
                                                                    ?
                                                                CircularPercentIndicator(
                                                                  radius: 35.0,
                                                                  lineWidth: 1.0,
                                                                  percent: 1.0,
                                                                  center:   CircleAvatar(
                                                                    radius: 34, // Image radius
                                                                    backgroundImage: NetworkImage(modal
                                                                        .sellerRevieviws
                                                                        .data![index]
                                                                        .userProfilePic!),
                                                                  ),
                                                                  progressColor: Colors.grey,
                                                                )

                                                                    :

                                                                const CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .grey,
                                                                        radius:
                                                                            35,
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              35,
                                                                          backgroundImage:
                                                                              AssetImage(
                                                                            MyImages.noImgPlaceHolder,
                                                                          ),
                                                                        )),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: screenSize
                                                                      .height *
                                                                  0.01,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                bottom: 10,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  LightTextBodyFuturaPTBook14(
                                                                    data: modal
                                                                        .sellerRevieviws
                                                                        .data![
                                                                            index]
                                                                        .stars!
                                                                        .toString(),
                                                                  ),
                                                                  SizedBox(
                                                                    width: screenSize
                                                                            .width *
                                                                        0.01,
                                                                  ),
                                                                  SvgPicture
                                                                      .asset(
                                                                    MyImages
                                                                        .icStar,
                                                                    height: 20,
                                                                    width: 20,
                                                                    allowDrawingOutsideViewBox:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenSize.width *
                                                                  0.02,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        left:
                                                                            0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    LightTextBodyFuturaPTBook18(
                                                                      data: modal
                                                                          .sellerRevieviws
                                                                          .data![
                                                                              index]
                                                                          .userName!,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              12),
                                                                      child:
                                                                          LightTextBodyFuturaPTBook11(
                                                                        data: Utility
                                                                            .readTimestamp(
                                                                          modal
                                                                              .sellerRevieviws
                                                                              .data![index]
                                                                              .createdAt!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: screenSize
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              SizedBox(
                                                                height: screenSize
                                                                        .height *
                                                                    0.10,
                                                                width: screenSize
                                                                        .width *
                                                                    0.60,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 2),
                                                                  child:
                                                                      LightTextBodyFuturaPTBook12(
                                                                    data: modal
                                                                        .sellerRevieviws
                                                                        .data![
                                                                            index]
                                                                        .description!,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                          )) // This trailing comma makes auto-formatting nicer for build methods.
                                      )))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: LightTextBodyFuturaPTHeavy18(
                                    data: 'notFound'.tr)),
                          ],
                        )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: LightTextBodyFuturaPTHeavy18(data: ''));
            }),
          ],
        ),
      ),
    );
  }
}

_getReviews(String yours_reviews, BuildContext context) {
  Provider.of<SellerReviewProvider>(context, listen: false).loading = false;
  Provider.of<SellerReviewProvider>(context, listen: false)
      .sellerReviews(yours_reviews, context);
}
