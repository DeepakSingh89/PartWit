import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/login_screen.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/utils/my_singleton.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _switchValue = true;
  bool isChanged = true;

  String textHolder='';
  SharedPreferences? pref;
  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'Español', 'locale': Locale('es', 'ES')},
    {'name': '中国人', 'locale': Locale('zh', 'CN')},
    {'name': 'Deutsch', 'locale': Locale('de', 'DE')},
    {'name': 'français', 'locale': Locale('fr', 'FR')}
  ];



  updateLanguage(Locale locale, String lng) {
    setState(() {
      pref!.setString('keyName',lng);
     textHolder = lng;

    });

    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title:   LightTextBodyFuturaPTMedium20(data: 'Choose Your Language',),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height*0.04,
                            child: Text(locale[index]['name'])),
                        onTap: () {
                          textHolder='';
                          print(locale[index]['name']);
                          pref!.remove("keyName");

                          updateLanguage(
                              locale[index]['locale'], locale[index]['name']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }


 @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    SharedPreferences   pref = await SharedPreferences.getInstance();
setState(() {
  textHolder= pref.getString('keyName')!;
  isChanged == true ? textHolder : textHolder = 'English';
  print('lng ${pref.getString('keyName')}');
});

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: Utility.actionBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
                  child: LightTextBodyFuturaPTMedium20(
                    data: 'settings'.tr,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 10, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(MyRouter.notification);
                                },
                                child: Container(
                                  color: MyAppTheme.whiteColor,
                                  width: screenSize.width / 2,
                                  child: LightTextBodyFuturaPTBook18(
                                    data: 'notifications'.tr,
                                  ),
                                ),
                              ),
                              CupertinoSwitch(
                                activeColor: MyAppTheme.buttonColor,
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                          child: Divider(color: MyAppTheme.border_Color),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(MyRouter.changePassword);
                          },
                          child: Container(
                            color: MyAppTheme.whiteColor,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: LightTextBodyFuturaPTBook18(
                                    data: 'changePsw'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                          child: Divider(color: MyAppTheme.border_Color),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child:  InkWell(
                            onTap: () {
                         PrefrencesData();
                              buildLanguageDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LightTextBodyFuturaPTBook18(
                                  data: 'language'.tr,
                                ),
                                SizedBox(
                                  width: screenSize.width*0.20,
                                  height: screenSize.height*0.025,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        if(textHolder.length==0) ...[
                                          LightTextBodyFuturaPTBook16(
                                            data:  'English' ,
                                          ),

                                        ] else  ...[
                                          LightTextBodyFuturaPTBook16(
                                            data: textHolder,
                                          ),
                                        ]

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                          child: Divider(color: MyAppTheme.border_Color),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(MyRouter.privacypolicy);
                          },
                          child: Container(
                            color: MyAppTheme.whiteColor,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  child: LightTextBodyFuturaPTBook18(
                                    data: 'privacyPolicy'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
                          child: Divider(color: MyAppTheme.border_Color),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(MyRouter.termscondition);
                          },
                          child: Container(
                            color: MyAppTheme.whiteColor,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 30),
                                  child: LightTextBodyFuturaPTBook18(
                                    data: 'terms'.tr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 7,
                    margin: const EdgeInsets.all(10),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.10,
                ),
                CustomButton(
                  'logout'.tr,
                  50,
                  onPressed: () async {
                    showAlertDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () async {
        try {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              ModalRoute.withName("/LoginScreen"));
        } on Exception catch (e) {
          e.printError();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Log Out"),
      content: const Text("Are you sure want to Logout?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void PrefrencesData() async {
      pref = await SharedPreferences.getInstance();
  }

}
