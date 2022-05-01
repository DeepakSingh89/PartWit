import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';

import 'package:part_wit/provider/HomeDetailsProvider.dart';
import 'package:part_wit/provider/ProductByCategoryProvider.dart';

import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/report_listing_dialog.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/text/LightTextBodyFuturaPTBold12.dart';
import 'package:part_wit/ui/widgets/text/LightTextBodyFuturaPTBold14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold24.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book14.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light12.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_light16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light16_yellow.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium24.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_green_futura_medium31.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_yellow_futura_book14.dart';
import 'package:part_wit/utils/Helpers.dart';

import 'package:part_wit/utils/utility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'chat/chat.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:readmore/readmore.dart';
class HomeItemsDetails extends StatefulWidget {
  const HomeItemsDetails({Key? key}) : super(key: key);

  @override
  State<HomeItemsDetails> createState() => _HomeItemsDetailsState();
}

class _HomeItemsDetailsState extends State<HomeItemsDetails> {
  late String catId;
  bool isLoad = true;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  List<Widget> imageSliders = [];

  @override
  Widget build(BuildContext context) {
    var catId = ModalRoute.of(context)?.settings.arguments;
    if (isLoad == true) {
      isLoad = false;

      if (catId != null) {
        setState(() {
          Helpers.verifyInternet().then((intenet) {
            if (intenet) {
              WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {

                    getHomeDetailsItems(catId.toString(), context)});
            } else {
              Helpers.createSnackBar(
                  context, "Please check your internet connection");
            }
          });
        });
      }
    }

    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: Utility.actionBar(),
        body: SingleChildScrollView(child: Consumer<HomeDetailsProvider>(
            builder: (BuildContext context, modal, Widget? child) {
          modal.loading
              ? modal.homeDetails.data != null
                  ? list(modal.homeDetails.data!.allImages)
                  : const Center(child: LightTextBodyFuturaPTHeavy18(data: ' ')) : const SizedBox(
                  width: 20,
                  height: 20,
                  child: LightTextBodyFuturaPTHeavy18(data: ' '));
          return modal.loading
              ? modal.homeDetails.data != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),

                        //viewpager
                        Center(
                          child: SizedBox(
                            height: screenSize.height * 0.35,
                            child: imageSliders != null && imageSliders.length >0
                                ? Column(children: [
                                    Expanded(
                                        child: CarouselSlider(
                                      items: imageSliders,
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                          height: 250,
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          aspectRatio: 2.0,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          }),
                                    )),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: modal
                                            .homeDetails.data!.allImages!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return GestureDetector(
                                            onTap: () => _controller
                                                .animateToPage(entry.key),
                                            child: Container(
                                              width: 30.0,
                                              height: 12.0,
                                              margin: const EdgeInsets.symmetric(
                                                  vertical: 8.0, horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  color: (Theme.of(context)
                                                      .brightness ==
                                                      Brightness.dark
                                                      ? Colors.yellow
                                                      : MyAppTheme
                                                      .backgroundColor)
                                                      .withOpacity(
                                                      _current == entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                            ),
                                          );
                                        }).toList(),
                                      ),


                                  ])
                                : Center(
                                    child:  Container()
                                    // Image.asset(MyImages.noImgPlaceHolder,
                                    //   fit: BoxFit.cover,  ),
                            ),
                          ),
                        ),


                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),

                        ///show details

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenSize.width*0.5,
                                  child: LightTextBodyFuturaPTBold18(
                                    data: modal.homeDetails.data!.name!,
                                  ),
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                LightTextBodyGreenFuturaPTMedium16(
                                  data: '\$' +
                                      modal.homeDetails.data!.price!.toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        try {
                                          Get.toNamed(
                                              MyRouter.sellerReviewScreen,
                                              arguments: {
                                                'name': modal.homeDetails.data!
                                                    .serllerInfo!.name,
                                                'review': modal.homeDetails.data!
                                                    .serllerInfo!.rating!.toStringAsFixed(2),
                                                'seller_Img': modal
                                                    .homeDetails
                                                    .data!
                                                    .serllerInfo!
                                                    .profilePic,
                                                'seller_id': modal.homeDetails
                                                    .data!.serllerInfo!.id,
                                              });
                                        } on Exception catch (e) {
                                          e.printError();
                                        }
                                      },
                                      child: CircularPercentIndicator(
              radius: 31.0,
              lineWidth: 1.0,
              percent: 1.0,
              center:   CircleAvatar(
              radius: 30, // Image radius
              backgroundImage: NetworkImage(modal
                  .homeDetails
                  .data!
                  .serllerInfo!
                  .profilePic!),
              ),
              progressColor: Colors.grey,
              )




                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.01,
                                    ),
                                    LightTextBodyFuturaPTBold14(
                                      data: modal
                                          .homeDetails.data!.serllerInfo!.name!,
                                    ),
                                    Row(
                                      children: [
                                        LightTextBodyFuturaPTBook14(
                                          data: modal.homeDetails.data!
                                              .serllerInfo!.rating!.toStringAsFixed(2),
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
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: screenSize.height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: screenSize.height * 0.03,
                                        ),
                                        Column(
                                          children: [
                                            LightTextBodyFuturaPTBold12(
                                              data: 'listedOn'.tr,
                                            ),

                                            SizedBox(
                                              height: screenSize.height * 0.02,
                                            ),
                                            LightTextBodyFuturaPTLight12(
                                              data: modal
                                                  .homeDetails.data!.listedOn!,
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.03,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            LightTextBodyFuturaPTBold12(
                                              data: 'expiresOn'.tr,
                                            ),

                                            SizedBox(
                                              height: screenSize.height * 0.02,
                                            ),
                                            LightTextBodyFuturaPTLight12(
                                              data: modal
                                                  .homeDetails.data!.expiresOn!,
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenSize.height * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            try {
                                              Get.toNamed(
                                                  MyRouter
                                                      .sellerAllReviewScreen,
                                                  arguments: modal.homeDetails
                                                      .data!.sellerId!);
                                            } on Exception catch (e) {
                                              e.printError();
                                            }
                                          },
                                          child:
                                              LightTextBodyYellowUnderlineFuturaPTBook14(
                                            data: 'seeReviewSeller'.tr,
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenSize.width * 0.03,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            try {
                                              share();
                                            } on Exception catch (e) {
                                              e.printError();
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            MyImages.icShare,
                                            alignment: Alignment.centerRight,
                                            allowDrawingOutsideViewBox: false,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 40, left: 40, top: 20, bottom: 20),
                              child:

                              ReadMoreText(
                                Utility.parseHtmlString(modal.homeDetails.data!.description!),
                                trimLines: 2,
                                colorClickableText:MyAppTheme.backgroundColor,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '...Show more',
                                trimExpandedText: ' show less',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontSize: 14,
                                  color: MyAppTheme.textPrimary,
                                  fontFamily: Fonts.futurPT,
                                  fontWeight: FontWeight.w500,

                                ),
                              ),
                              // LightTextBodyFuturaPTMedium14(
                              //   data: Utility.parseHtmlString(modal.homeDetails.data!.description!) ,
                              // ),
                            ),
                          ],
                        ),

                        Container(
                          height: screenSize.height * 0.05,
                          width: screenSize.width * 0.40,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: MyAppTheme.textPrimary),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              try {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ReportListingDialog(
                                          catId.toString());
                                    });
                              } on Exception catch (e) {
                                e.printError();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  MyImages.icFlag,
                                  alignment: Alignment.centerRight,
                                  allowDrawingOutsideViewBox: false,
                                ),
                                SizedBox(
                                  width: screenSize.width * 0.02,
                                ),
                                LightTextBodyFuturaPTBook12(
                                  data: 'reportListing'.tr,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.02,
                              ),
                              ButtonTheme(
                                minWidth: screenSize.width * 0.40,
                                height: screenSize.height * 0.07,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: MyAppTheme.buttonShadow_Color)),
                                child: RaisedButton(
                                  elevation: 5.0,
                                  hoverColor: MyAppTheme.buttonShadow_Color,
                                  color: MyAppTheme.backgroundColor,
                                  child: LightTextBodyFuturaPTLight16(
                                    data: 'messageSeller'.tr,
                                  ),
                                  onPressed: () {
                                    Helpers.verifyInternet().then((intenet) {
                                      if (intenet) {
                                        WidgetsBinding.instance!.addPostFrameCallback(
                                                (_) => {

                                                ApiServices.addChatUser(modal.homeDetails
                                                    .data!.sellerId.toString(),context).then((response) {
                                                if(response!.status==true){


                                                Navigator.of(context).push(
                                                MaterialPageRoute(
                                                builder: (ctx) => ChatScreen(modal
                                                    .homeDetails.data!.allImages![0],modal
                                                    .homeDetails.data!.serllerInfo!.name!,modal
                                                    .homeDetails.data!.serllerInfo!.profilePic!),
                                                ),
                                                );
                                                }else{
                                                  Helpers.createSnackBar(
                                                      context, response.message);
                                                }

                                                })


                                                });
                                      } else {
                                        Helpers.createSnackBar(
                                            context, "Please check your internet connection");
                                      }
                                    });



                                  },
                                ),
                              ),
                              ButtonTheme(
                                minWidth: screenSize.width * 0.40,
                                height: screenSize.height * 0.07,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                        color: MyAppTheme.buttonShadow_Color)),
                                child: RaisedButton(
                                  elevation: 5.0,
                                  hoverColor: MyAppTheme.buttonShadow_Color,
                                  color: MyAppTheme.whiteColor,
                                  child: LightTextBodyYellowFuturaPTLight16(
                                    data: 'saveItem'.tr,
                                  ),
                                  onPressed: () {
                                    try {
                                      print('${modal.homeDetails.data!.id}');
                                       ApiServices.addToSaveItems(modal.homeDetails.data!.id.toString(),context).then((response) {
                                         setState(() {
                                           if (response!.status == true) {
                                             Get.toNamed(MyRouter.saveItems);
                                           }else{

                                           }
                                         });
                                       });

                                    //
                                    } on Exception catch (e) {
                                      e.printError();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: screenSize.width * 0.02,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                      ],
                    )
                  : const Center(child: LightTextBodyFuturaPTHeavy18(data: ' '))
              : const SizedBox(
                  width: 20,
                  height: 20,
                  child: LightTextBodyFuturaPTHeavy18(data: ' '));
        })),
      ),
    );
  }

  ///share app link method
  Future<void> share() async {
    await FlutterShare.share(
        title: 'PartWit App',
        text: 'Download amazing PartWit app!',
        linkUrl: 'https://google.com/',
        chooserTitle: 'PartWit Business App');
  }

  getCategoryByList(String s, BuildContext context) {
    Provider.of<ProductByCateProvider>(context, listen: false).loading = false;
    Provider.of<ProductByCateProvider>(context, listen: false)
        .ProductByCat(s, context);
  }

  void list(List? allImages) {

    allImages != null && allImages.length >0
        ? imageSliders = allImages
            .map((item) => Container(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: item != null? Stack(
                          children: <Widget>[

                            item !=
                                null &&
                                item!.isNotEmpty
                                ?


                            Image.network(item,
                            fit: BoxFit.cover, width: 1000.0,
                            loadingBuilder:
                            (BuildContext context,
                            Widget child,
                            ImageChunkEvent?
                            loadingProgress) {
                        if (loadingProgress == null)
                    return child;
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
    }
                            )
                                : Utility.placeHolder(),


                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ):
                        Center(
                          child: Image.asset(MyImages.noImgPlaceHolder,
                            fit: BoxFit.cover,  ),
                        ),),
                  ),
                ))
            .toList()
        :  Center(
      child: Image.asset(MyImages.noImgPlaceHolder,
        fit: BoxFit.cover,  ),
    );
  }
}

getHomeDetailsItems(String id, BuildContext context) {
  Provider.of<HomeDetailsProvider>(context, listen: false).loading = false;

  Provider.of<HomeDetailsProvider>(context, listen: false)
      .singleProductDetailsShow(id, context);
}
