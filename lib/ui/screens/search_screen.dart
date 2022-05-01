import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/SearchProvider.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_grey_futura_book25.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  var searchTextCtrl = TextEditingController();
  bool isVisible = false;
  bool isVisibleItems = false;
  bool isVisibleNoItem = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isVisibleItems=true;
      isVisibleNoItem = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double itemHeight = screenSize.height / 4.4;
    final double itemWidth = screenSize.width / 2;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: searchTextCtrl,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  setState(() {
                    isVisible = true;
                    isVisibleItems = false;
                    isVisibleNoItem=false;
                    Helpers.verifyInternet().then((intenet) {
                      if (intenet) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) => {
                              getSearchItemsList(searchTextCtrl.text, context),
                            });
                      } else {
                        Helpers.createSnackBar(
                            context, "Please check your internet connection");
                      }
                    });
                  });
                },
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: MyAppTheme.textPrimary,
                  fontFamily: Fonts.futurPT,
                  fontWeight: FontWeight.w500,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  } else if (value.length < 5) {
                    return 'Password must be greater then 5';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyAppTheme.whiteColor,
                  hintText: 'searchMiles'.tr,
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    color: MyAppTheme.textPrimary,
                    fontFamily: Fonts.futurPT,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 12, bottom: 12, right: 16),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = true;
                          isVisibleItems = false;
                          isVisibleNoItem=false;
                          Helpers.verifyInternet().then((intenet) {
                            if (intenet) {
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) => {

                                        getSearchItemsList(
                                            searchTextCtrl.text, context),
                                      });
                            } else {
                              Helpers.createSnackBar(context,
                                  "Please check your internet connection");
                            }
                          });
                        });
                      },
                      child: SvgPicture.asset(
                        MyImages.icSearchSmall,
                        alignment: Alignment.center,
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: MyAppTheme.whiteColor),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: MyAppTheme.whiteColor),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: MyAppTheme.buttonShadow_Color, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0)),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        searchTextCtrl.clear();
                        setState(() {
                          isVisibleNoItem=true;
                          isVisible = false;
                          isVisibleItems = true;
                        });
                      },
                      child: SvgPicture.asset(
                        MyImages.icCross,
                        alignment: Alignment.centerRight,
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Offstage(
            offstage: isVisible,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    MyImages.icSearchLarge,
                    alignment: Alignment.center,
                    allowDrawingOutsideViewBox: false,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  LightTextBodyGreyFuturaPTBook25(
                    data: 'searchParwit'.tr,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<SearchProvider>(
                builder: (BuildContext context, modal, Widget? child) {
              return modal.loading
                  ? modal.searchData.data != null &&
                          modal.searchData.data!.products!.length > 0
                      ? Offstage(
                          offstage: isVisibleItems,
                          child: GridView.builder(
                            itemCount: modal.searchData.data!.products!.length,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return modal.searchData.data!.products!.length > 0
                                  ? InkWell(
                                      onTap: () {
                                        Get.toNamed(MyRouter.homeItemsDetails,
                                            arguments: modal.searchData.data!
                                                .products![index].id);
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
                                            if (modal.searchData.data != null &&
                                                modal.searchData.data!.products!
                                                        .length >
                                                    index)
                                              Expanded(
                                                  child: modal.searchData.data!.products![index].featuredImage! != null &&
                                                          modal.searchData.data!
                                                              .products![index]
                                                              .featuredImage!
                                                              .isNotEmpty
                                                      ?

                                      Image.network(
                                          modal
                                              .searchData
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
                                          })


                                                      : Utility.placeHolder()),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 120.0,
                                                        child:   LightTextBodyFuturaPTMedium18(
                                                          data: modal
                                                              .searchData
                                                              .data!
                                                              .products![index]
                                                              .name!,
                                                        )
                                                      ),
                                                 LightTextBodyFuturaPTLight11(
                                                        data: modal
                                                            .searchData
                                                            .data!
                                                            .products![index]
                                                            .date!,
                                                      ),
                                                    ],
                                                  ),
                                                  LightTextBodyFuturaPTMedium18(
                                                    data: '\$' +
                                                        modal
                                                            .searchData
                                                            .data!
                                                            .products![index]
                                                            .price!
                                                            .toString(),
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
                          ),
                        )
                      : Offstage(
                offstage:  isVisibleNoItem,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: LightTextBodyFuturaPTHeavy18(
                                      data: 'noDataFound'.tr)),
                            ],
                          ),
                      )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: LightTextBodyFuturaPTHeavy18(data: ' '));
            }),
          ),
        ],
      ),
    ));
  }

  getSearchItemsList(String text, BuildContext context) {
    Provider.of<SearchProvider>(context, listen: false).loading = false;
    Provider.of<SearchProvider>(context, listen: false)
        .searchItem(text, context);
  }
}
