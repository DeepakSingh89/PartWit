import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AttributesModel.dart';
import 'package:part_wit/model/CategoryListedForSaleModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/provider/AttributesProvider.dart';
import 'package:part_wit/provider/CategoryListedForSaleProvider.dart';
import 'package:part_wit/provider/EditProductProvider.dart';
import 'package:part_wit/provider/ToastProvider.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy28.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:provider/provider.dart';

import 'package:part_wit/utils/utility.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert' show utf8, base64;

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  bool? isVisible = false;
  bool? isImgField = true;
  List<XFile>? imageFileList = [];
  List<int>? deleteIndex = [];

  final TextEditingController itemController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController osController = TextEditingController();
  final TextEditingController internalMController = TextEditingController();
  final TextEditingController resolutionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final _productKey = GlobalKey<FormState>();
  final _cateKey = GlobalKey<FormState>();
  final _colorKey = GlobalKey<FormState>();
  final _brandKey = GlobalKey<FormState>();
  final _modelKey = GlobalKey<FormState>();
  final _modalKey = GlobalKey<FormState>();
  final _osKey = GlobalKey<FormState>();
  final _internalKey = GlobalKey<FormState>();
  final _resolutionKey = GlobalKey<FormState>();

  final _amountKey = GlobalKey<FormState>();
  final _disKey = GlobalKey<FormState>();

  bool _cate = false,
      _color = false,
      _brand = false,
      _model = false,
      _modal = false,
      _os = false,
      _memory = false,
      _res = false,
      _amount = false,
      _dis = false;

  String? name, price, description, category_id;
  int? color_id, brand_id, model_id, os_id, memory_id, resolution_id;
  int? color_value_id,
      brand_value_id,
      type_value_id,
      model_value_id,
      os_value_id,
      memory_value_id,
      resolution_value_id;

  _pickMultiImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    List<XFile>? selectedImage = await _picker.pickMultiImage(imageQuality: 50);
    if (selectedImage!.isNotEmpty) {
      if (selectedImage.length <= 15) {
        imageFileList!.addAll(selectedImage);
        print('if   ${selectedImage.length}');
      } else {
        Utility.toast('imgMsg'.tr);
      }

      setState(() {});
    }
  }

  void _removeImg(int index, String s) async {
    if (s == 'network') {
      deleteIndex!.add(index);
      imagFileList!.removeAt(index);
    } else {
      imageFileList!.removeAt(index);
    }

    setState(() {});
  }

  updateText(String title) {
    setState(() {
      itemController.text = title;
    });

    Get.back();
  }

  updateText_(String title, int index, int i, int id, String? proName) {
    print('555${proName}');
    setState(() {
      if (proName == 'Colour') {
        colorController.text = title;
        color_value_id = id;
      } else if (proName == 'Color') {
        colorController.text = title;
        color_value_id = id;
      } else if (proName == 'Colors') {
        colorController.text = title;
        color_value_id = id;
      } else if (proName == 'Type') {
        typeController.text = title;
        type_value_id = id;
      } else if (proName == 'Brand') {
        brandController.text = title;
        brand_value_id = id;
      } else if (proName == 'Model') {
        modelController.text = title;
        model_value_id = id;
      } else if (proName == 'Modal') {
        modelController.text = title;
        model_value_id = id;
      } else if (proName == 'Operating System') {
        osController.text = title;
        os_value_id = id;
      } else if (proName == 'Internal Memory') {
        internalMController.text = title;
        memory_value_id = id;
      } else if (proName == 'Resolution') {
        resolutionController.text = title;
        resolution_value_id = id;
      }
    });

    Get.back();
  }

  attributesDialog(
    BuildContext context,
    List<Brand>? attributeList,
    int i,
    String? title,
  ) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
              title: LightTextBodyFuturaPTMedium20(
                data: 'selectCategory'.tr,
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: attributeList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: Text(attributeList[index].title!)),
                        onTap: () {
                          updateText_(attributeList[index].title!, index, i,
                              attributeList[index].id!, title);
                          setState(() {});
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                ),
              ));
        });
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
                                      category_id = modal
                                          .itemsData.data![index].id
                                          .toString();
                                      name = modal.itemsData.data![index].title
                                          .toString();
                                      print('cat id ${category_id}');
                                      updateText(
                                          modal.itemsData.data![index].title!);
                                      Helpers.verifyInternet().then((intenet) {
                                        if (intenet) {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback((_) => {
                                                    getAttributeItemsList(
                                                        modal.itemsData
                                                            .data![index].id!,
                                                        context),
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

  bool expand = false;
  int? tapped;

  bool isLoad = true;
  List<String>? imagFileList = [];
  String? identity;
  var proId;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    isImgField = true;
    proId = ModalRoute.of(context)!.settings.arguments;
    if (isLoad == true) {
      isLoad = false;

      if (proId != null) {
        setState(() {
          identity = Constant.IDENTITY;
          Helpers.verifyInternet().then((intenet) {
            if (intenet) {
              WidgetsBinding.instance!.addPostFrameCallback((_) => {
                    ApiServices.getdetailProducts(context, proId.toString())
                        .then((response) {
                      if (response!.status == true) {
                        nameController.text = response.data!.name!;
                        desController.text = response.data!.description!;
                        priceController.text = response.data!.price.toString();
                        getAttributeItemsList(
                            response.data!.categoryId!, context);
                        imagFileList!.clear();
                        for (var i = 0;
                            i < response.data!.categories!.length;
                            i++) {
                          if (response.data!.categoryId ==
                              response.data!.categories![i].id) {
                            itemController.text =
                                response.data!.categories![i].title!;
                            category_id =
                                response.data!.categories![i].id.toString();
                          }
                        }

                        for (var i = 0;
                            i < response.data!.allImages!.length;
                            i++) {
                          imagFileList!.add(response.data!.allImages![i]);
                        }
                        setState(() {
                          imagFileList!;
                        });

                        for (var i = 0;
                            i < response.data!.productAttributes!.length;
                            i++) {
                          if (response.data!.productAttributes![i].title ==
                              'Colour') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .colour!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .colour![k].selected ==
                                    true) {
                                  color_id = response.data!
                                      .productAttributes![i].colour![k].id!;
                                  colorController.text = response.data!
                                      .productAttributes![i].colour![k].title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Color') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .colour!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .colour![k].selected ==
                                    true) {
                                  color_id = response.data!
                                      .productAttributes![i].colour![k].id!;
                                  colorController.text = response.data!
                                      .productAttributes![i].colour![k].title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Colors') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .colour!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .colour![k].selected ==
                                    true) {
                                  color_id = response.data!
                                      .productAttributes![i].colour![k].id!;
                                  colorController.text = response.data!
                                      .productAttributes![i].colour![k].title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Brand') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .brand!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .brand![k].selected ==
                                    true) {
                                  brand_id = response.data!
                                      .productAttributes![i].brand![k].id!;
                                  brandController.text = response.data!
                                      .productAttributes![i].brand![k].title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Model') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .model!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .model![k].selected ==
                                    true) {
                                  model_id = response.data!
                                      .productAttributes![i].model![k].id!;
                                  modelController.text = response.data!
                                      .productAttributes![i].model![k].title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Operating System') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .operatingSystem!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .operatingSystem![k].selected ==
                                    true) {
                                  os_id = response.data!.productAttributes![i]
                                      .operatingSystem![k].id!;
                                  osController.text = response
                                      .data!
                                      .productAttributes![i]
                                      .operatingSystem![k]
                                      .title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Internal Memory') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .internalMemory!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .internalMemory![k].selected ==
                                    true) {
                                  memory_id = response
                                      .data!
                                      .productAttributes![i]
                                      .internalMemory![k]
                                      .id!;
                                  internalMController.text = response
                                      .data!
                                      .productAttributes![i]
                                      .internalMemory![k]
                                      .title!;
                                }
                              }
                            }
                          } else if (response
                                  .data!.productAttributes![i].title ==
                              'Resolution') {
                            if (response.data!.productAttributes![i].selected ==
                                true) {
                              for (var k = 0;
                                  k <
                                      response.data!.productAttributes![i]
                                          .resolution!.length;
                                  k++) {
                                if (response.data!.productAttributes![i]
                                        .resolution![k].selected ==
                                    true) {
                                  resolution_id = response.data!
                                      .productAttributes![i].resolution![k].id!;
                                  resolutionController.text = response
                                      .data!
                                      .productAttributes![i]
                                      .resolution![k]
                                      .title!;
                                  print(
                                      '======rs===${resolutionController.text}');
                                }
                              }
                            }
                          }
                        }
                      }
                    }),
                  });
            } else {
              Helpers.createSnackBar(
                  context, "Please check your internet connection");
            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (imageFileList != null && imageFileList!.isNotEmpty) {
      setState(() {
        isVisible = true;
        isImgField = false;
      });
    } else if (imagFileList != null && imagFileList!.isNotEmpty) {
      setState(() {
        isVisible = true;
        isImgField = false;
      });
    } else {
      setState(() {
        isVisible = false;
        isImgField = true;
      });
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(0)),
            ModalRoute.withName("/HomeScreen"));

        //we need to return a future
        return Future.value(true);
      },
      child: SafeArea(
          child: GestureDetector(
        onTap: () {
          ///hide keyboard function
          Utility.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: MyAppTheme.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Row(
                    children: [
                      FlatButton(
                          padding: const EdgeInsets.all(0.0),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(0)),
                                    ModalRoute.withName("/HomeScreen"))
                              }),
                      SizedBox(
                        width: screenSize.width * 0.03,
                      ),
                      Center(
                        child: LightTextBodyFuturaPTHeavy28(
                          data: 'createProductListing'.tr,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Offstage(
                      offstage: isImgField!,
                      child: Row(
                        children: [
                          imageFileList!.isNotEmpty
                              ? Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: screenSize.height * 0.15),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: ListView.builder(
                                          physics: const ScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: imageFileList!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4, right: 4),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.file(
                                                      File(
                                                        imageFileList![index]
                                                            .path,
                                                      ),
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  right: 7,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _removeImg(index, '');
                                                    },
                                                    child: const Icon(
                                                      Icons.close_outlined,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                )
                              : Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: screenSize.height * 0.15),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: ListView.builder(
                                          physics: const ScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: imagFileList!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4, right: 4),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                        imagFileList![index],
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext
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
                                                    }),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  right: 7,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _removeImg(
                                                          index, 'network');
                                                    },
                                                    child: const Icon(
                                                      Icons.close_outlined,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                        ],
                      )),
                  Offstage(
                    offstage: isVisible!,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _pickMultiImageFromGallery();
                          },
                          child: SvgPicture.asset(
                            MyImages.icAdd,
                            alignment: Alignment.centerRight,
                            allowDrawingOutsideViewBox: false,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.03,
                        ),
                        LightTextBodyFuturaPTHeavy18(
                          data: 'addImg'.tr,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          color: MyAppTheme.buttonShadow_Color,
                          child: Form(
                            key: _productKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: TextFormField(
                                    maxLength: 30,
                                    // inputFormatters:  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), ]  ,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: MyAppTheme.black_Color,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    enabled: true,
                                    obscureText: false,
                                    controller: nameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter product name';
                                      } else if (value.length < 3) {
                                        return 'Password must be greater then 3';
                                      } else if (value.length > 30) {
                                        return 'Password must be less then 30';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      filled: true,
                                      fillColor: MyAppTheme.buttonShadow_Color,
                                      hintText: 'productName'.tr,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        color: MyAppTheme.textPrimary,
                                        fontFamily: Fonts.futurPT,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                                MyAppTheme.buttonShadow_Color),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyAppTheme
                                                  .buttonShadow_Color),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyAppTheme.whiteColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          color: MyAppTheme.buttonShadow_Color,
                          child: Form(
                            key: _cateKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    colorController.clear();
                                    brandController.clear();
                                    modelController.clear();
                                    osController.clear();
                                    internalMController.clear();
                                    resolutionController.clear();
                                    priceController.clear();
                                    desController.clear();
                                    buildItemDialog(context);
                                  },
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: MyAppTheme.black_Color,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    enabled: false,
                                    obscureText: false,
                                    controller: itemController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Select Category';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        _cate = true;
                                        _color = false;
                                        _brand = false;
                                        _model = false;
                                        _modal = false;
                                        _os = false;
                                        _memory = false;
                                        _res = false;
                                        _amount = false;
                                        _dis = false;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: MyAppTheme.buttonShadow_Color,
                                      hintText: 'itemCate'.tr,
                                      errorStyle: TextStyle(color: Colors.red),
                                      suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: MyAppTheme.textPrimary_),
                                      hintStyle: const TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        color: MyAppTheme.textPrimary,
                                        fontFamily: Fonts.futurPT,
                                        fontWeight: FontWeight.w100,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color:
                                                MyAppTheme.buttonShadow_Color),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyAppTheme
                                                  .buttonShadow_Color),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: MyAppTheme.whiteColor,
                                              width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  Flexible(
                    child: Consumer<AttributeProvider>(
                        builder: (BuildContext context, modal, Widget? child) {
                      return modal.loading
                          ? modal.attributeData.data != null
                              ? ListView.builder(
                                  itemCount: modal.attributeData.data!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      Column(
                                        children: [
                                          if (modal.attributeData.data![index]
                                                  .title ==
                                              'Colour') ...[
                                            InkWell(
                                              onTap: () {
                                                color_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].colour,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _colorKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              colorController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Color';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = true;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Colors') ...[
                                            InkWell(
                                              onTap: () {
                                                color_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].colors,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _colorKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              colorController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Color';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = true;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Color') ...[
                                            InkWell(
                                              onTap: () {
                                                color_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].color,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _colorKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              colorController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Color';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = true;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Brand') ...[
                                            InkWell(
                                              onTap: () {
                                                brand_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].brand,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _brandKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              brandController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Brand';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = true;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) //
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Model') ...[
                                            InkWell(
                                              onTap: () {
                                                model_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].model,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _modelKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              modelController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Model';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = false;
                                                              _model = true;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Modal') ...[
                                            InkWell(
                                              onTap: () {
                                                model_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal.attributeData
                                                        .data![index].modal,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _modalKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              modelController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Model';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = true;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .black_Color,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Operating System') ...[
                                            InkWell(
                                              onTap: () {
                                                os_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal
                                                        .attributeData
                                                        .data![index]
                                                        .operatingSystem,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _osKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              osController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select OS';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = true;
                                                              _memory = false;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Internal Memory') ...[
                                            InkWell(
                                              onTap: () {
                                                memory_id = modal.attributeData
                                                    .data![index].id;
                                                attributesDialog(
                                                    context,
                                                    modal
                                                        .attributeData
                                                        .data![index]
                                                        .internalMemory,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _internalKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              internalMController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Internal Memory';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = true;
                                                              _res = false;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ] else if (modal.attributeData
                                                  .data![index].title ==
                                              'Resolution') ...[
                                            InkWell(
                                              onTap: () {
                                                resolution_id = modal
                                                    .attributeData
                                                    .data![index]
                                                    .id;
                                                attributesDialog(
                                                    context,
                                                    modal
                                                        .attributeData
                                                        .data![index]
                                                        .resolution,
                                                    index,
                                                    modal.attributeData
                                                        .data![index].title);
                                              },
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          40, 0, 40, 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    child: Form(
                                                      key: _resolutionKey,
                                                      child: Container(
                                                        color: MyAppTheme
                                                            .buttonShadow_Color,
                                                        child: TextFormField(
                                                          style:
                                                              const TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 16,
                                                            color: MyAppTheme
                                                                .black_Color,
                                                            fontFamily:
                                                                Fonts.futurPT,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          enabled: false,
                                                          obscureText: false,
                                                          controller:
                                                              resolutionController,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please Select Resolution';
                                                            }
                                                            return null;
                                                          },
                                                          onTap: () {
                                                            setState(() {
                                                              _cate = false;
                                                              _color = false;
                                                              _brand = false;
                                                              _model = false;
                                                              _modal = false;
                                                              _os = false;
                                                              _memory = false;
                                                              _res = true;
                                                              _amount = false;
                                                              _dis = false;
                                                            });
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                            filled: true,
                                                            fillColor: MyAppTheme
                                                                .buttonShadow_Color,
                                                            hintText: modal
                                                                .attributeData
                                                                .data![index]
                                                                .title,
                                                            suffixIcon:
                                                                const Icon(Icons
                                                                    .arrow_drop_down),
                                                            hintStyle:
                                                                const TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: MyAppTheme
                                                                  .textPrimary,
                                                              fontFamily:
                                                                  Fonts.futurPT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: MyAppTheme
                                                                      .buttonShadow_Color),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: MyAppTheme
                                                                        .buttonShadow_Color),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: MyAppTheme
                                                                        .whiteColor,
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                                  ),
                                            ),
                                          ]
                                        ],
                                      ))

                              //  )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Center(
                                        child: LightTextBodyFuturaPTHeavy18(
                                            data: ' ')),
                                  ],
                                )
                          : const SizedBox(
                              width: 20,
                              height: 20,
                              child: LightTextBodyFuturaPTHeavy18(data: ''));
                    }),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          color: MyAppTheme.buttonShadow_Color,
                          child: Form(
                            key: _amountKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9a-zA-Z]")),
                                  ],
                                  style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: MyAppTheme.black_Color,
                                    fontFamily: Fonts.futurPT,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  enabled: true,
                                  obscureText: false,
                                  controller: priceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter amount';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    setState(() {
                                      _cate = false;
                                      _color = false;
                                      _brand = false;
                                      _model = false;
                                      _modal = false;
                                      _os = false;
                                      _memory = false;
                                      _res = false;
                                      _amount = true;
                                      _dis = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyAppTheme.buttonShadow_Color,
                                    hintText: 'itemAmount'.tr,
                                    hintStyle: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: MyAppTheme.textPrimary,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: MyAppTheme.buttonShadow_Color),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                MyAppTheme.buttonShadow_Color),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyAppTheme.whiteColor,
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      height: 200,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          color: MyAppTheme.buttonShadow_Color,
                          child: Form(
                            key: _disKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  // inputFormatters:Utility.inputFormatters ( ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: MyAppTheme.black_Color,
                                    fontFamily: Fonts.futurPT,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  enabled: true,
                                  obscureText: false,
                                  controller: desController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please provide details';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: MyAppTheme.buttonShadow_Color,
                                    hintText: 'itemDes'.tr,
                                    hintStyle: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: MyAppTheme.textPrimary,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: MyAppTheme.buttonShadow_Color),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                MyAppTheme.buttonShadow_Color),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyAppTheme.whiteColor,
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomButton('uploadProductList'.tr, 54, onPressed: () {
                    print('${proId}');
                    print('${identity}');
                    List<String> imgs = [];
                    List<String> product_attribut = [];
                    List<String> product_attribut_values = [];

                    imgs.clear();
                    product_attribut.clear();
                    product_attribut_values.clear();

                    try {
                      product_attribut.add(color_id.toString());
                      product_attribut.add(brand_id.toString());
                      product_attribut.add(model_id.toString());
                      product_attribut.add(os_id.toString());
                      product_attribut.add(memory_id.toString());
                      product_attribut.add(resolution_id.toString());

                      product_attribut_values.add(color_value_id.toString());
                      product_attribut_values.add(brand_value_id.toString());
                      product_attribut_values.add(model_value_id.toString());
                      product_attribut_values.add(os_value_id.toString());
                      product_attribut_values.add(memory_value_id.toString());
                      product_attribut_values
                          .add(resolution_value_id.toString());
                    } on Exception catch (e) {
                      e.printError();
                    }

                    List<String> imgList = [];
                    imgList.clear();

                    for (var i = 0; i < imageFileList!.length; i++) {
                      imgList.add("\"" +
                          Utility.imgTobase64Encode(imageFileList![i].path) +
                          "\"");
                    }

                    if (nameController.text.isEmpty) {
                      Utility.toast('Please enter name');
                    } else if (itemController.text.isEmpty) {
                      Utility.toast('Please select category');
                    } else if (itemController.text == 'Phones') {
                      if (colorController.text.isEmpty) {
                        Utility.toast('Please select color');
                      } else if (brandController.text.isEmpty) {
                        Utility.toast('Please select brand');
                      } else if (modelController.text.isEmpty) {
                        Utility.toast('Please select model');
                      } else if (osController.text.isEmpty) {
                        Utility.toast('Please select OS');
                      } else if (internalMController.text.isEmpty) {
                        Utility.toast('Please select memory');
                      } else if (resolutionController.text.isEmpty) {
                        Utility.toast('Please select resolution');
                      } else if (priceController.text.isEmpty) {
                        Utility.toast('Please enter amount');
                      } else {
                        setState(() {
                          uploadData(product_attribut, imgList,
                              product_attribut_values);
                        });
                      }
                    } else if (itemController.text == 'Bikes') {
                      if (modelController.text.isEmpty) {
                        Utility.toast('Please select model');
                      } else if (priceController.text.isEmpty) {
                        Utility.toast('Please enter amount');
                      } else {
                        setState(() {
                          uploadData(product_attribut, imgList,
                              product_attribut_values);
                        });
                      }
                    } else if (itemController.text == 'Cars') {
                      if (modelController.text.isEmpty) {
                        Utility.toast('Please select model');
                      } else if (priceController.text.isEmpty) {
                        Utility.toast('Please enter amount');
                      } else {
                        setState(() {
                          uploadData(product_attribut, imgList,
                              product_attribut_values);
                        });
                      }
                    } else if (itemController.text == 'Beauty') {
                      if (priceController.text.isEmpty) {
                        Utility.toast('Please enter amount');
                      } else {
                        setState(() {
                          uploadData(product_attribut, imgList,
                              product_attribut_values);
                        });
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget expandableListView(
      int index, String? title, bool isExpanded, Data data) {
    debugPrint('List item build $index $isExpanded');
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          child: Column(
            children: <Widget>[
              Container(
                color: MyAppTheme.buttonShadow_Color,
                padding: const EdgeInsets.only(
                    top: 5.5, bottom: 5.5, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: LightTextBodyFuturaPTBook16(
                        data: title!,
                      ),
                    ),
                    IconButton(
                        icon: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                            color: MyAppTheme.buttonShadow_Color,
                            // shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up_outlined
                                  : Icons.arrow_drop_down_outlined,
                              color: MyAppTheme.textPrimary_,
                              size: 25.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            expand = ((tapped == null) ||
                                    ((index == tapped) || !expand))
                                ? !expand
                                : expand;
                            tapped = index;
                          });
                        }),
                  ],
                ),
              ),
              if (title == 'Colour') ...[
                loadList(data.colour, isExpanded)
              ] else if (title == 'Brand') ...[
                loadList(data.brand, isExpanded)
              ] else if (title == 'Model') ...[
                loadList(data.model, isExpanded)
              ] else if (title == 'Operating System') ...[
                loadList(data.operatingSystem, isExpanded)
              ] else if (title == 'Internal Memory') ...[
                loadList(data.internalMemory, isExpanded)
              ] else if (title == 'Resolution') ...[
                loadList(data.resolution, isExpanded)
              ]
            ],
          ),
        ),
      ),
    );
  }

  void uploadData(
    List<String> product_attribut,
    List<String> imgList,
    List<String> product_attribut_values,
  ) {
    Helpers.verifyInternet().then((intenet) {
      if (intenet) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => {
              ApiServices.addProducts(
                      proId.toString(),
                      nameController.text,
                      desController.text,
                      desController.text,
                      priceController.text,
                      category_id!,
                      product_attribut,
                      product_attribut_values,
                      context,
                      imgList,
                      identity,
                      deleteIndex)
                  .then((value) {
                if (value!.status == true) {
                  Utility.toast(value.message);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(0)),
                      ModalRoute.withName("/HomeScreen"));
                } else {
                  Utility.toast(value.message);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen(0)),
                      ModalRoute.withName("/HomeScreen"));
                }
              })
            });
      } else {
        Helpers.createSnackBar(
            context, "Please check your internet connection");
      }
    });
  }
}

loadList(
  List<Brand>? list,
  bool isExpanded,
) {
  return ExpandableContainer(
      expanded: isExpanded,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.0, color: MyAppTheme.buttonShadow_Color),
                color: MyAppTheme.buttonShadow_Color),
            child: ListTile(
              title: LightTextBodyFuturaPTBook16(
                data: list![index].title!,
              ),
              leading: const Icon(
                Icons.arrow_drop_down_sharp,
                color: MyAppTheme.textPrimary_,
              ),
            ),
          );
        },
        itemCount: list?.length,
      ));
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 200.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
        decoration: BoxDecoration(
            border:
                Border.all(width: 1.0, color: MyAppTheme.buttonShadow_Color)),
      ),
    );
  }
}

getAttributeItemsList(int id, BuildContext context) {
  Provider.of<AttributeProvider>(context, listen: false).loading = false;
  Provider.of<AttributeProvider>(context, listen: false)
      .attributesList(id.toString(), context);
}

getEditList(String id, BuildContext context) {
  Provider.of<EditProductProvider>(context, listen: false).loading = false;
  Provider.of<EditProductProvider>(context, listen: false)
      .productList(id, context);
}

String? validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contain more than 5 characters";
  }
  return null;
}
