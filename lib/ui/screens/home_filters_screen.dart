import 'package:flutter/material.dart';
import 'package:part_wit/model/ColorModel.dart';
import 'package:part_wit/model/FilterModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/provider/CategoryListedForSaleProvider.dart';
import 'package:part_wit/provider/FliterProvider.dart';
import 'package:part_wit/provider/HomeFilterProductProvider.dart';
import 'package:part_wit/repository/range_repo.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/custom_widgets/RadioButton.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class HomeFiltersScreen extends StatefulWidget {
  const HomeFiltersScreen({Key? key}) : super(key: key);

  @override
  State<HomeFiltersScreen> createState() => _HomeFiltersScreenState();
}

class _HomeFiltersScreenState extends State<HomeFiltersScreen> {
  bool rememberMeActive = false;
  late bool isSelected;
  String? title_ = 'Phones';
  String? from = 'from'.tr;
  String? to = 'to'.tr;
String? category_id,year_from,year_to,min_price='500',max_price='5000';
List<String?> att_val=[];
  String? color_id='1' ;


  double _startValue = 1.0;
  double _endValue = 50.0;

  var selectedIndex = 0;
  String textHolder = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = false;
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback((_) => {
            getCategoryItemsList(context),
          getFilter(1,context),

          });
        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });

  }

  updateText(String title) {
    setState(() {
      title_ = title;
    });

    Get.back();
  }

  buildItemDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: LightTextBodyFuturaPTMedium20(
              data: 'selectCategory'.tr,
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Consumer<CategoryListedForSaleProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.itemsData.data != null &&
                            modal.itemsData.data!.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  child: Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                      child: Text(
                                          modal.itemsData.data![index].title!)),
                                  onTap: () {
                                    setState(() {
                                      category_id=modal.itemsData.data![index].id.toString();
                                      updateText(
                                          modal.itemsData.data![index].title!);
                                      Helpers.verifyInternet().then((intenet) {
                                        if (intenet) {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback((_) => {

                                                    getFilter(
                                                        modal.itemsData
                                                            .data![index].id,
                                                        context)
                                                  });
                                        } else {
                                          Helpers.createSnackBar(context,
                                              "Please check your internet connection");
                                        }
                                      });
                                    });
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.blue,
                              );
                            },
                            itemCount: modal.itemsData.data!.length)
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
          );
        });
  }

  // Call this in the select year button.
  void _pickYear(BuildContext context, String f) {
    showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text('Select a Year'),
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: size.height / 3,
            width: size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                // Generating a list of 123 years starting from 2022
                // Change it depending on your needs.
                ...List.generate(
                  123,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        if (f == 'from') {
                          from = (2022 - index).toString();
                          year_from=(2022 - index).toString();
                        } else {
                          to = (2022 - index).toString();
                          year_to = (2022 - index).toString();
                        }
                      });

                      Navigator.pop(context);
                    },
                    // This part is up to you, it's only ui elements
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            // Showing the year text, it starts from 2022 and ends in 1900 (you can modify this as you like)
                            (2022 - index).toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              title: LightTextBodyFuturaPTHeavy28(
                data: 'filters'.tr,
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
                        onPressed: () =>
                            {Utility.hideKeyboard(context), Get.back()}),
              ),
            ),


            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenSize.width * 0.05,
                            right: screenSize.width * 0.05,
                            top: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LightTextBodyFuturaPTBold18(data: 'category'.tr),
                            SizedBox(
                              height: screenSize.height * 0.015,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: InkWell(
                                onTap: () {
                                  buildItemDialog(context);
                                },
                                child: Container(
                                    color: MyAppTheme.textfield_bg_grayColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LightTextBodyFuturaPTBook16(
                                            data: title_!,
                                          ),
                                          SvgPicture.asset(
                                            MyImages.icDropDownBlack,
                                            alignment: Alignment.centerRight,
                                            allowDrawingOutsideViewBox: false,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.03,
                            ),
                            LightTextBodyFuturaPTBold18(data: 'brand'.tr),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: screenSize.height * 0.07,
                                  maxHeight: screenSize.height * 0.25,
                                ),
                                child: Consumer<FilterProvider>(builder:
                                    (BuildContext context, modal, Widget? child) {
                                  return modal.loading
                                      ? modal.filterData.data != null
                                          ? ListView.builder(
                                              shrinkWrap: false,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: modal.filterData.data!
                                                  .attributes!.length,
                                              itemBuilder: (BuildContext context,
                                                  int index) {
                                                return Column(
                                                  children: [
                                                    if (modal
                                                            .filterData
                                                            .data!
                                                            .attributes![index]
                                                            .title ==
                                                        'Brand') ...[


                                                      MyListItemD(
                                                          modal
                                                              .filterData
                                                              .data!
                                                              .attributes![index]
                                                              .brand,


                                                             )
                                                    ]
                                                  ],
                                                );
                                              })
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                    child:
                                                        LightTextBodyFuturaPTHeavy18(
                                                            data: 'noRecord'.tr)),
                                              ],
                                            )
                                      : const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: LightTextBodyFuturaPTHeavy18(
                                              data: ''));
                                }),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            LightTextBodyFuturaPTBold18(data: 'colour'.tr),
                            Flexible(
                                child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: screenSize.height * 0.05,
                                maxHeight: screenSize.height * 0.10,
                              ),
                              child: Consumer<FilterProvider>(builder:
                                  (BuildContext context, modal, Widget? child) {
                                return modal.loading
                                    ? modal.filterData.data != null
                                        ? ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount:modal.filterData.data!.attributes!.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return modal.filterData.data!.attributes![index].colour !=null? LoadColor(modal.filterData.data!.attributes![index].colour! ) : Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: const [
                                                  Center(
                                                      child:
                                                      LightTextBodyFuturaPTHeavy18(
                                                          data: ' ')),
                                                ],
                                              );
                                            })
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child:
                                                      LightTextBodyFuturaPTHeavy18(
                                                          data: 'noRecord'.tr)),
                                            ],
                                          )
                                    : const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child:
                                            LightTextBodyFuturaPTHeavy18(data: ''));
                              }),
                            )),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            LightTextBodyFuturaPTBold18(data: 'year'.tr),
                            SizedBox(
                              height: screenSize.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                      width: screenSize.width * 0.40,
                                      color: MyAppTheme.textfield_bg_grayColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: InkWell(
                                          onTap: () {
                                            _pickYear(context, 'from');
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LightTextBodyFuturaPTBook16(
                                                data: from!,
                                              ),
                                              SvgPicture.asset(
                                                MyImages.icDropDownBlack,
                                                alignment: Alignment.centerRight,
                                                allowDrawingOutsideViewBox: false,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      _pickYear(context, 'to');
                                    },
                                    child: Container(
                                        width: screenSize.width * 0.40,
                                        color: MyAppTheme.textfield_bg_grayColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LightTextBodyFuturaPTBook16(
                                                data: to!,
                                              ),
                                              SvgPicture.asset(
                                                MyImages.icDropDownBlack,
                                                alignment: Alignment.centerRight,
                                                allowDrawingOutsideViewBox: false,
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.02,
                            ),
                            LightTextBodyFuturaPTBold18(data: 'priceRange'.tr),

                            Row(
                              children: [

                                LightTextBodyFuturaPTBook16(
                                    data: '\$ ' +
                                        Utility.calc_range(_startValue).toString()),
                                const LightTextBodyFuturaPTBook16(data: ' - '),
                                LightTextBodyFuturaPTBook16(
                                    data: '\$ ' +
                                        Utility.calc_range(_endValue).toString()),
                              ],
                            ),
                            SizedBox(
                              height: screenSize.height * 0.00,
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 10.0,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0),
                                overlayColor: Colors.red.withAlpha(32),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: RangeSlider(
                                activeColor: MyAppTheme.buttonColor,
                                inactiveColor: MyAppTheme.textfield_bg_grayColor,
                                min: 0.0,
                                max: 100.0,
                                values: RangeValues(_startValue, _endValue),
                                onChanged: (values) {
                                  setState(() {

                                    _startValue = values.start;
                                    min_price=Utility.calc_range(_startValue).toString();
                                    _endValue = values.end;
                                    max_price=Utility.calc_range(_endValue).toString();

                                  });
                                },
                              ),
                            ),



                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 110,
                  ),
                  Consumer<FilterProvider>(builder: (context, modal, child) {
                    return  Container(
                      height: 100,
                      color: MyAppTheme.backgroundColor,
                      child: CustomButton(
                        'submit'.tr,
                        54,
                        onPressed: () {
                          att_val.clear();
                          att_val.add(color_id);
                          att_val.add(modal.isSelected.toString());

                          Get.toNamed(MyRouter.homeFilterProducts,
                            arguments:  {
                              'category_id': category_id,
                              'att_val': att_val,
                              'year_from': year_from,
                              'year_to': year_to,
                              'min_price': min_price,
                              'max_price': max_price,
                            },
                          );

                          // Helpers.verifyInternet().then((intenet) {
                          //   if (intenet) {
                          //     WidgetsBinding.instance!
                          //         .addPostFrameCallback((_) => {
                          //
                          //       getFilteredData(category_id,att_val,year_from,year_to,min_price,max_price,context)
                          //
                          //
                          //       // ApiServices.getFilterProducts(category_id,att_val,year_from,year_to,min_price,max_price,context).then((value) {
                          //       //   print('Status  ${value!.status}');
                          //       //         if(value.status==true){
                          //       //
                          //       //   }
                          //       // })
                          //       // getFilteredData(category_id,att_val,year_from,year_to,min_price,max_price, context)
                          //     });
                          //   } else {
                          //     Helpers.createSnackBar(context,
                          //         "Please check your internet connection");
                          //   }
                          // });

                        },
                      ),
                    );

                  }),
                ],
              ),
            )));
  }

  getFilter(int? id, BuildContext context) {
    print('## @@ ${id}');
    Provider.of<FilterProvider>(context, listen: false).loading = false;
    Provider.of<FilterProvider>(context, listen: false)
        .filterList(id.toString(), context);
  }

  Widget MyListItemD(List<Brand>? brand,  ) {

    return Consumer<FilterProvider>(builder: (context, modal, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: brand!.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child:
                  LightTextBodyFuturaPTBook16(data: brand[index].title!,)

                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: modal.isSelected == index
                        ? const Icon(Icons.radio_button_checked,
                            color: Colors.grey)
                        : const Icon(Icons.radio_button_unchecked,
                            color: Colors.grey),
                    onPressed: () {
                      modal.selectCard(index,brand[index].id!);
                    },
                  ),
                ),
              ],
            );
          });
    });
  }

  Widget LoadColor(List<Brand> list,) {
    print('${list.length}');
    return ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:list.length,
          itemBuilder:
              (BuildContext context, int index) {
            return    InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  color_id=list[index].id.toString();
                });
              },
              child: Padding(
                padding:
                const EdgeInsets.all(5.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Utility.hexToColor(list[index].color!) ,
                    shape: BoxShape.circle,
                  ),
                  child: selectedIndex == index
                      ? const Icon(
                    Icons.check,
                    color: MyAppTheme
                        .whiteColor,
                  )
                      : null,
                ),
              ),
            );
          });



  }




}
