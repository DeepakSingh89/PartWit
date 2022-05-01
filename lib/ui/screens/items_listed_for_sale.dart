import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/provider/CategoryListedForSaleProvider.dart';
import 'package:part_wit/provider/itemsListedForSaleProvider.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium28.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:get/get_core/src/get_main.dart';

class ItemsListedForSale extends StatefulWidget {
  const ItemsListedForSale({Key? key}) : super(key: key);

  @override
  State<ItemsListedForSale> createState() => _ItemsListedForSaleState();
}

class _ItemsListedForSaleState extends State<ItemsListedForSale> {
  int selectedIndex = 0;
  int? selectItem;
  String? cat_id;

  bool isVisible = true;
  bool isVisi = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback((_) => {
                getCategoryItemsList(context),
                if (selectedIndex == 0)
                  {
                    getItemsList('1', context),
                  }
              });
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
    final double itemHeight = screenSize.height / 4;
    final double itemWidth = screenSize.width / 2;
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
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
            builder: (context) => // Ensure Scaffold is in context
            // ignore: deprecated_member_use
            FlatButton(
                padding: const EdgeInsets.all(0.0),
                child: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                onPressed: () => {Utility.hideKeyboard(context), Get.back()}),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'featuredPost'.tr, }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],


        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: LightTextBodyFuturaPTMedium20(
                data: 'itemsListed'.tr,
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              child: Consumer<CategoryListedForSaleProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.itemsData.data != null &&
                            modal.itemsData.data!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: modal.itemsData.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    cat_id=modal.itemsData.data![index].id
                                        .toString();
                                    getItemsList(
                                        modal.itemsData.data![index].id
                                            .toString(),
                                        context);
                                  });
                                },
                                child: Card(
                                  color: selectedIndex == index
                                      ? MyAppTheme.backgroundColor
                                      : MyAppTheme.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Container(
                                    width: 120,
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Center(
                                        child: Text(
                                      modal.itemsData.data![index].title!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 15,
                                          fontFamily: Fonts.futurPT,
                                          fontWeight: selectedIndex == index
                                              ? FontWeight.w500
                                              : FontWeight.w500,
                                          color: selectedIndex == index
                                              ? MyAppTheme.whiteColor
                                              : MyAppTheme.black_Color),
                                    )),
                                  ),
                                ),
                              );
                            })
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
              }),
            ),
            Consumer<ItemsListedForSaleProvider>(
                builder: (BuildContext context, modal, Widget? child) {
              return Expanded(
                child: modal.loading
                    ? modal.listedForSaleItems.data!.products != null &&
                            modal.listedForSaleItems.data!.products!.isNotEmpty
                        ? GridView.builder(
                            itemCount:
                                modal.listedForSaleItems.data!.products!.length,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    selectItem = index;

                                  });

                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Positioned(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectItem = null;
                                                    Get.toNamed(MyRouter.homeItemsDetails,
                                                        arguments:
                                                        modal.listedForSaleItems.data!.products![index].id);
                                                  });
                                                },
                                                child:
                                                modal
                                                    .listedForSaleItems
                                                    .data!
                                                    .products![index]
                                                    .featuredImage! != null &&  modal
                                                    .listedForSaleItems
                                                    .data!
                                                    .products![index]
                                                    .featuredImage!.isNotEmpty ?

                                                Image.network(
                                                    modal
                                                        .listedForSaleItems
                                                        .data!
                                                        .products![index]
                                                        .featuredImage!,
                                                    height: 140,
                                                    width: 160,
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
                                                    },
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    return Utility.placeHolder();
                                                  },
                                                )
                                                : Utility.placeHolder(),
                                              ),
                                            ),
                                            selectItem == index
                                                ? Positioned(
                                                    top: screenSize.height *
                                                        0.04,
                                                    left:
                                                        screenSize.width * 0.12,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap:(){
                                                            print('****${modal.listedForSaleItems.data!.products![index].id}');
                                                            Get.toNamed(MyRouter.addItemsScreen,
                                                                arguments: modal.listedForSaleItems.data!.products![index].id);
                              },

                                                          child: SvgPicture.asset(
                                                            MyImages.icEditBtn,
                                                            width: 45,
                                                            height: 45,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenSize.width *
                                                                  0.01,
                                                        ),
                                                        InkWell(
                                                          onTap:(){
                                                            print('****${modal.listedForSaleItems.data!.products![index].id}');
                                                            print('***ss*${cat_id}');
                                                           ApiServices.deleteProduct(context, modal.listedForSaleItems.data!.products![index].id.toString()).then((response) {
                                                             if(response!.status==true){
                                                               setState(() {
                                                                 Provider.of<ItemsListedForSaleProvider>(context, listen: false)
                                                                     .productItemsList(  cat_id!, context);
                                                               });
                                                             }
                                                           });
                                                          },

                                                          child: SvgPicture.asset(
                                                            MyImages.icDeleteBtn,
                                                            width: 45,
                                                            height: 45,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Positioned(
                                                    top: 1,
                                                    right: 0,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        width:
                                                            screenSize.width *
                                                                0.15,
                                                        height:
                                                            screenSize.height *
                                                                0.04,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          child: Container(
                                                            color: MyAppTheme
                                                                .backgroundColor,
                                                            child: Center(
                                                                child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 3),
                                                                  child: SvgPicture
                                                                      .asset(
                                                                    MyImages
                                                                        .icEyes,
                                                                    allowDrawingOutsideViewBox:
                                                                        false,
                                                                  ),
                                                                ),
                                                                LightTextBodyFuturaPTBold11(
                                                                  data: modal
                                                                      .listedForSaleItems
                                                                      .data!
                                                                      .products![
                                                                          index]
                                                                      .viewCount
                                                                      .toString(),
                                                                )
                                                              ],
                                                            )),
                                                          ),
                                                        )),
                                                  ),
                                          ],
                                        ),
                                        Row(
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
                                                LightTextBodyFuturaPTMedium18(
                                                  data: modal
                                                      .listedForSaleItems
                                                      .data!
                                                      .products![index]
                                                      .name!,
                                                ),
                                                LightTextBodyFuturaPTLight11(
                                                  data: modal
                                                      .listedForSaleItems
                                                      .data!
                                                      .products![index]
                                                      .date!,
                                                )
                                              ],
                                            ),
                                            LightTextBodyFuturaPTMedium18(
                                              data: '\$' +
                                                  modal.listedForSaleItems.data!
                                                      .products![index].price
                                                      .toString(),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
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
                        child: LightTextBodyFuturaPTHeavy18(data: '')),
              );
            })
          ],
        ),
      ),
    );
  }

  getCategoryItemsList(BuildContext context) {
    Provider.of<CategoryListedForSaleProvider>(context, listen: false).loading =
        false;

    Provider.of<CategoryListedForSaleProvider>(context, listen: false)
        .catList(context);
  }

  getItemsList(String id, BuildContext context) {
    Provider.of<ItemsListedForSaleProvider>(context, listen: false).loading =
        false;
    Provider.of<ItemsListedForSaleProvider>(context, listen: false)
        .productItemsList(id, context);
  }


  void handleClick(String value) {
    switch (value) {
      case 'Featured Post':  Get.toNamed(MyRouter.planScreen, arguments: {
        'type': Constant.FEATURED,
        'isVisible':true,
      });
        break;

    }
  }
}
