import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/ProductListModel.dart';
import 'package:part_wit/network/ApiServices.dart';

import 'package:part_wit/provider/HomeListProvider.dart';
import 'package:part_wit/provider/ProductByCategoryProvider.dart';

import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium14.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium28.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:provider/provider.dart';

import '../home_item_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  List<ProductModel> prodList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback((_) => {
            ///using this api for category list only
                getHomeItemsList(context),
                if (selectedIndex == 0)
                  {
                    ///using this api for category wise list of data !
                    getCategoryByList('1', context),
                  }

                // if (selectedIndex == 0) {
                //   _loadProductData('1', context);
                // }
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 4.4;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),

            ///Categories Items container
            Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: MediaQuery.of(context).size.width,
              child: Consumer<HomeListProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.homeListData.data != null &&
                            modal.homeListData.data!.isNotEmpty
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: modal.homeListData.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return modal.loading
                                  ? modal.homeListData.data != null &&
                                          modal.homeListData.data!.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;

                                              getCategoryByList(
                                                  modal.homeListData
                                                      .data![index].catId
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
                                                  color: Colors.white70,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Container(
                                              width: 120,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: Center(
                                                  child: Text(
                                                modal.homeListData.data![index]
                                                    .title!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15,
                                                    fontFamily: Fonts.futurPT,
                                                    fontWeight:
                                                        selectedIndex == index
                                                            ? FontWeight.w500
                                                            : FontWeight.w500,
                                                    color: selectedIndex ==
                                                            index
                                                        ? MyAppTheme.whiteColor
                                                        : MyAppTheme
                                                            .black_Color),
                                              )),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: LightTextBodyFuturaPTHeavy18(
                                              data: 'noRecord'.tr))
                                  : const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: LightTextBodyFuturaPTHeavy18(
                                          data: ''));
                            })
                        : Center(
                            child: LightTextBodyFuturaPTHeavy18(
                                data: 'noRecord'.tr))
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: LightTextBodyFuturaPTHeavy18(data: ''));
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<ProductByCateProvider>(
                builder: (BuildContext context, modal, Widget? child) {
              return modal.loading
                  ? modal.productData.data != null &&
                          modal.productData.data!.length > 0
                      ? GridView.builder(
                          itemCount: modal.productData.data!.length,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return modal.productData.data!.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      Get.toNamed(MyRouter.homeItemsDetails,
                                          arguments: modal
                                              .productData.data![index].id);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          if (modal.productData.data != null &&
                                              modal.productData.data!.length >
                                                  index)
                                            Expanded(
                                              child: modal
                                                              .productData
                                                              .data![index]
                                                              .featuredImage !=
                                                          null &&
                                                      modal
                                                          .productData
                                                          .data![index]
                                                          .featuredImage!
                                                          .isNotEmpty
                                                  ?
                                              Image.network(
                                                      modal
                                                          .productData
                                                          .data![index]
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
                                                    })
                                                  : Image.asset(
                                                      MyImages.noImgPlaceHolder,
                                                      width: 100,
                                                      height: 100,
                                                fit: BoxFit.cover,
                                                    ),
                                            ),
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
                                                      child: LightTextBodyFuturaPTMedium18(
                                                        data: modal.productData
                                                            .data![index].name!,
                                                      ),
                                                    ),
                                                    LightTextBodyFuturaPTLight11(
                                                      data: modal.productData
                                                          .data![index].date!,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 60.0,
                                                  child: LightTextBodyFuturaPTMedium16(
                                                    data: '\$' +
                                                        modal.productData
                                                            .data![index].price!
                                                            .toString(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container();
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Center(
                                child: LightTextBodyFuturaPTHeavy18(data: '')),
                          ],
                        )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: LightTextBodyFuturaPTHeavy18(data: ' '));
            }),
          ],
        ),
      ),
    );
  }

  _loadProductData(String id, BuildContext context) {
    ApiServices.getProductByCategory(id, context).then((response) {
      if (response.status == true) {
        prodList.clear();
        for (var i = 0; i < response.data!.length; i++) {
          prodList.add(ProductModel(
            response.data![i].featuredImage,
            response.data![i].date,
            response.data![i].name,
            response.data![i].id,
            response.data![i].price,
          ));
        }
      }
    });
  }
}

getHomeItemsList(BuildContext context) {
  Provider.of<HomeListProvider>(context, listen: false).loading = false;
  Provider.of<HomeListProvider>(context, listen: false).HomeListItems(context);
}

/// get product by category
getCategoryByList(String cat_id, BuildContext context) {
  Provider.of<ProductByCateProvider>(context, listen: false).loading = false;
  Provider.of<ProductByCateProvider>(context, listen: false)
      .ProductByCat(cat_id, context);
}
