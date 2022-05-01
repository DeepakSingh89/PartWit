import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/SellerRecentItemsModel.dart';
import 'package:part_wit/provider/SellerProfileProvider.dart';
import 'package:part_wit/provider/SellerRecentItemsProvider.dart';
import 'package:part_wit/ui/screens/seller_review_dialog.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book19.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium28.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';

class SellerReviewScreen extends StatefulWidget {
  const SellerReviewScreen({Key? key}) : super(key: key);

  @override
  State<SellerReviewScreen> createState() => _SellerReviewScreenState();
}

class _SellerReviewScreenState extends State<SellerReviewScreen> {
  final double circleRadius = 120.0;
  bool isLoad = true;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 4.4;
    final double itemWidth = screenSize.width / 2;

    var rcvdData = ModalRoute.of(context)!.settings.arguments as Map;

    if (isLoad == true) {
      isLoad = false;

      if (rcvdData != null) {
        setState(() {
          Helpers.verifyInternet().then((intenet) {
            if (intenet) {
              WidgetsBinding.instance!.addPostFrameCallback(
                      (_) => {

                        getRecentItemsList(rcvdData['seller_id'].toString(), context)});
            } else {
              Helpers.createSnackBar(
                  context, "Please check your internet connection");
            }
          });
        });
      }
    }


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _imageWithBar(screenSize, rcvdData['seller_Img']),
            SizedBox(
              height: screenSize.height * 0.00,
            ),
            LightTextBodyFuturaPTBook19(
              data: rcvdData['name'],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LightTextBodyFuturaPTBook14(
                  data: rcvdData['review'],
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                SvgPicture.asset(
                  MyImages.icStar,
                  alignment: Alignment.centerRight,
                  allowDrawingOutsideViewBox: false,
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 10, 10),
                child: LightTextBodyFuturaPTBook23(
                  data: 'recentlyListedItems'.tr,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenSize.height * .5,
                  minHeight: screenSize.height * .05),
              child: Consumer<SellerProfileProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.sellerProfileData.data != null &&
                            modal.sellerProfileData.data!.products!.isNotEmpty
                        ? GridView.builder(
                            itemCount:
                                modal.sellerProfileData.data!.products!.length,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, top: 10, bottom: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      modal.sellerProfileData.data!
                                          .products![index].featuredImage! != null &&
                                          modal
                                              .sellerProfileData.data!
                                              .products![index].featuredImage!
                                              .isNotEmpty
                                          ?
                                      Image.network(
                                          modal.sellerProfileData.data!
                                              .products![index].featuredImage!,
                                          height: 130,
                                          width: 150,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext
                                          context,
                                              Widget child,
                                              ImageChunkEvent?
                                              loadingProgress) {
                                            if (loadingProgress ==
                                                null) return child;
                                            return Center(
                                              child:
                                              CircularProgressIndicator(
                                                value: loadingProgress
                                                    .expectedTotalBytes !=
                                                    null
                                                    ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          })

                                          : Utility.placeHolder(),


                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100.0,
                                                  child: LightTextBodyFuturaPTMedium16(
                                                    data: modal
                                                        .sellerProfileData
                                                        .data!
                                                        .products![index]
                                                        .name!,
                                                  ),
                                                ),
                                                LightTextBodyFuturaPTLight12(
                                                  data: modal
                                                      .sellerProfileData
                                                      .data!
                                                      .products![index]
                                                      .date!,
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 60.0,
                                              child: LightTextBodyFuturaPTMedium16(
                                                data: '\$' +
                                                    modal.sellerProfileData.data!
                                                        .products![index].price
                                                        .toString(),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
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
                        child:  LightTextBodyFuturaPTHeavy18(
                            data: ' '));
              }),
            ),
            SizedBox(
              height: screenSize.height * 0.00,
            ),
          ],
        ),
        bottomNavigationBar: CustomButton(
          'reviewSeller'.tr,
          50,
          onPressed: () {
            try {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SellerReviewDailog(
                      rcvdData['seller_Img'],
                      rcvdData['seller_id'].toString(),
                    );
                  });
            } on Exception catch (e) {
              e.printError();
            }
          },
        ),
      ),
    );
  }

  _imageWithBar(Size screenSize, rcvdData) {
    return Flexible(
        child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenSize.height * 0.20),
      child: Stack(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: circleRadius / 2.0,
              ),
              child: Container(
                height: screenSize.height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),
                  color: MyAppTheme.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                )),
                          ],
                        )
                      ],
                    )),
              ),
            ),

            ///Image Avatar
            Card(
              elevation: 8.0,
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(rcvdData!),
                  )),
            )
          ],
        ),
      ]),
    ));
  }

  getRecentItemsList(String seller_id, BuildContext context ) {
    Provider.of<SellerProfileProvider>(context, listen: false).loading =
        false;

    Provider.of<SellerProfileProvider>(context, listen: false)
        .sellerProfle(seller_id,context);
  }
}
