import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book19.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book20.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_light15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _usernameController = TextEditingController();
  String? imgUrl = "";
  String? name = "";
  String? email = "";
  String? plan ="";
  String? rating ="";

  void getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));

    setState(() {

      _usernameController.text = user.userInfo!.name ?? "";
      //name = user.userInfo!.name;
      email = user.userInfo!.email!;
      imgUrl = user.userInfo!.profilePic!;
      rating= pref.getString('rating')!;
      plan=pref.getString('plan')!;
      print('==========${rating}');
      print('==========${plan}');
    });
  }

  @override
  void initState() {
    super.initState();
  //  getUser();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      getUser();
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              imgUrl != null && imgUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 60.0, backgroundImage:  NetworkImage(imgUrl!) )
                  : const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(MyImages
                                .ic_person //Convert File type of image to asset image path),
                            ),
                      )),
              SizedBox(
                height: screenSize.height * 0.02,
              ),

              TextFormField(
                textAlign: TextAlign.center,
                maxLength: 15,
                textAlignVertical: TextAlignVertical.center,
                enabled: false,
                controller: _usernameController,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: MyAppTheme.textPrimary,
                  fontFamily: Fonts.futurPT,
                  fontWeight: FontWeight.w200,
                ),
                obscureText: false,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
              //  LightTextBodyFuturaPTDemi20(data: name==null?"":name!,),

              LightTextBodyFuturaPTLight15(
                data: email == null ? "" : email!,
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenSize.width*0.09,
                    height:screenSize.width*0.05 ,

                    child: Align(
                      alignment: Alignment.centerRight,
                      child: LightTextBodyFuturaPTBook19(
                        data: rating!,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.01,
                  ),
                  SvgPicture.asset(
                    MyImages.icStar,
                    height: 25,
                    width: 25,
                    allowDrawingOutsideViewBox: true,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  try {
                    Get.toNamed(MyRouter.saveItems);
                  } on Exception catch (e) {
                    e.printError();
                  }
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'savedItems'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.itemsListedForSale);
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'ItemsListed'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.editProfile);
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'editProfile'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.yourReview);
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'seeReviews'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.aboutPartWit);
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'aboutPartWit'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.settings);
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: MyAppTheme.items_bg_Color,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LightTextBodyFuturaPTBook20(
                                data: 'settings'.tr,
                              ),
                              SvgPicture.asset(
                                MyImages.icRightArrow,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) // This trailing comma makes auto-formatting nicer for build methods.
                    ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: MyAppTheme.plan_bg_Color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      color: MyAppTheme.items_bg_Color,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LightTextBodyFuturaPTBook15(
                                  data: 'current'.tr,
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.01,
                                ),

                                LightTextBodyFuturaPTMedium16(
                                  data: plan!,
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 15.0, bottom: 15.0),
                                  width: 100,
                                  height: 40,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Container(
                                      color: MyAppTheme.backgroundColor,
                                      child: Center(
                                        child: LightTextBodyFuturaPTBook15(
                                          data: 'update'.tr,
                                        ),
                                      ),
                                    ),
                                  ) // This trailing comma makes auto-formatting nicer for build methods.
                                  ),
                              onTap: () {

                                Get.toNamed(MyRouter.planScreen,arguments: {
                                'type': Constant.SUBSCRIPTION_PLAN,
                                  'isVisible':true,
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
