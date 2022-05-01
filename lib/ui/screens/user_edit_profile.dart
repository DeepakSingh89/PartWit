import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_wit/model/ModelRegister.dart';
import 'package:part_wit/repository/update_user_profile_repository.dart';

import 'package:part_wit/ui/screens/home_screen.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_book17.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book24.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium11.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_grey_futura_book25.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? imgUrl;

  void getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = ModeRegister.fromJson(jsonDecode(pref.getString('user')!));
    setState(() {
      _usernameController.text =
          user.userInfo!.name ?? "";
      _emailController.text = user.userInfo!.email! ;
      imgUrl = user.userInfo!.profilePic!  ;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          ///hide keyboard function
          Utility.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: MyAppTheme.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 5),
                          child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: MyAppTheme.black_Color,
                                size: 30,
                              ),
                              onPressed: () => {Get.back()}),
                        ),
                        Container(
                            child: Center(
                          child: Image.asset(
                            MyImages.ic_app_logo,
                            width: 80,
                            height: 80,
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  LightTextBodyFuturaPTBook24(
                    data: 'Edit Profile'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  imageProfile(context),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  LightTextBodyFuturaPTBook17(
                    data: 'Change Profile Photo'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: double.infinity,
                          ),
                          color: MyAppTheme.buttonShadow_Color,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                child: LightTextBodyFuturaPTMedium11(
                                  data: 'Your Name'.tr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: TextFormField(
                                  inputFormatters: Utility.inputFormatters(),
                                  keyboardType: TextInputType.text,
                                  textAlignVertical: TextAlignVertical.top,
                                  maxLength: 15,
                                  style:  const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 19,
                                    color: MyAppTheme.textPrimary,
                                    fontFamily: Fonts.futurPT,
                                    fontWeight: FontWeight.w500,),
                                  enabled: true,
                                  obscureText: false,
                                  controller: _usernameController,
                                  textInputAction: TextInputAction.done,

                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'Please enter name';
                                    } else if (!validateName(value)) {
                                      return value.length < 3
                                          ? 'Name must be greater than three characters'
                                          : null;
                                    }
                                    else if (!validateName(value)) {
                                      return 'Name must be valid and doesn\'t allow any special character';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    filled: true,
                                    counterText: "",
                                    fillColor: MyAppTheme.buttonShadow_Color,
                                    hintText: 'Enter Your Name'.tr,
                                    hintStyle:  const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 19,
                                      color: MyAppTheme.textPrimary,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w500,),
                                    errorMaxLines: 2,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: MyAppTheme.buttonShadow_Color),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyAppTheme.buttonShadow_Color),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: MyAppTheme.whiteColor,
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(15.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: double.infinity,
                          ),
                          color: MyAppTheme.buttonShadow_Color,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15, top: 5),
                                child: LightTextBodyFuturaPTMedium11(
                                  data: 'Email '.tr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.top,
                                  style:  const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 19,
                                    color: MyAppTheme.textPrimary,
                                    fontFamily: Fonts.futurPT,
                                    fontWeight: FontWeight.w500,),
                                  enabled: false,
                                  obscureText: false,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    filled: true,
                                    fillColor: MyAppTheme.buttonShadow_Color,
                                    hintText: 'Enter Your Email'.tr,
                                    hintStyle:  const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 19,
                                      color: MyAppTheme.textPrimary,
                                      fontFamily: Fonts.futurPT,
                                      fontWeight: FontWeight.w500,),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: MyAppTheme.buttonShadow_Color),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) // This trailing comma makes auto-formatting nicer for build methods.
                      ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Column(
                    children: [
                      CustomButton(
                        'Save'.tr,
                        50,
                        onPressed: () {
                          try {
                            if (_formKey.currentState!.validate()) {
                              Helpers.verifyInternet().then((internet) {
                                if (internet) {
                                  String uName=_usernameController.text.trim();
                                  if (_imageFile == null) {


                                    if(uName.length>=3){
                                      createUserUpdateData(File(""),
                                          _usernameController.text, context)
                                          .then((response) {
                                        setState(() {
                                          if (response.status!) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomeScreen(4)),
                                                ModalRoute.withName("/HomeScreen"));
                                          }
                                        });
                                      });
                                    }else{
                                      Utility.toast('Name must be greater than three characters');
                                    }

                                  } else {

                                    if(uName.length>=3){
                                      createUserUpdateData(_imageFile!,
                                          _usernameController.text.trim(), context)
                                          .then((response) {
                                        setState(() {
                                          if (response.status!) {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomeScreen(4)),
                                                ModalRoute.withName("/HomeScreen"));

                                          }


                                        });
                                      });
                                    }

                                  }
                                } else {
                                  Helpers.createSnackBar(context,
                                      "Please check your internet connection");
                                }
                              });
                            }

                          } on Exception catch (e) {
                            e.printError();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
              child: InkWell(
            onTap: () {
              openSheet();
            },
            child: _imageFile != null
                ? getImageWidget()
                : imgUrl != null
                    ?
            // FadeInImage.assetNetwork(placeholder: MyImages.loading,//MyImages.ic_person
            //     fadeOutDuration: Duration(seconds: 2),
            //     image: imgUrl!
            // )
            CircleAvatar(
                        radius: 60.0, backgroundImage: NetworkImage(imgUrl!))

                    : getImageWidget(),
          )),
          Positioned(
            bottom: 0,
            right: 5,
            child: InkWell(
              onTap: () {
                openSheet();
              },
              child: SvgPicture.asset(
                MyImages.icEdit,
                alignment: Alignment.centerRight,
                allowDrawingOutsideViewBox: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future takePhoto(ImageSource source) async {
    try {} on Exception catch (_) {
      // print('Failed to pic image $e');
    }
    final _imageFile = await _picker.pickImage(source: source);
    if (_imageFile == null) return;

    final imageTemporary = File(_imageFile.path);
    this._imageFile = imageTemporary;
    try {
      setState(() => this._imageFile = imageTemporary);

      Navigator.pop(context);
    } on Exception catch (_) {}
  }

  getImageWidget() {
    if (_imageFile != null) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 60,
        child: CircleAvatar(
          radius: 60.0,
          backgroundImage: Image.file(_imageFile!).image,
        ),
      );
    } else {
      return const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 60,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(MyImages.ic_person //Convert File type of image to asset image path),
                ),
          ));
    }
  }

  void openSheet() {
    showModalBottomSheet(
      context: context,
      builder: ((builder) => bottomSheet(context)),
    );
  }

  bottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height:screenSize.height*0.30 ,
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [

            Wrap(
              children: <Widget>[
                  ListTile(
                  title:  LightTextBodyGreyFuturaPTBook25(data: 'selectType'.tr,),
                ),
                ListTile(

                  title:   LightTextBodyFuturaPTBold18(data: 'camera'.tr, ),
                  onTap: () {
                    takePhoto(ImageSource.camera);
                    // Navigator.of(context).pop();
                  },
                ),
                  ListTile(

                    title:   LightTextBodyFuturaPTBold18(data: 'gallery'.tr, ),
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                      // Navigator.of(context).pop();
                    }),
                ListTile(
                  title:   LightTextBodyFuturaPTBold18(data: 'cancel'.tr, ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextButton.icon(
            //       icon: const Icon(
            //         Icons.camera,
            //         color: Colors.grey,
            //       ),
            //       onPressed: () {
            //         takePhoto(ImageSource.camera);
            //       },
            //       label: const Text('Camera',
            //           style: TextStyle(
            //               color: Colors.grey,
            //               fontFamily: 'Opensans',
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16)),
            //     ),
            //     TextButton.icon(
            //       icon: const Icon(
            //         Icons.image,
            //         color: Colors.grey,
            //       ),
            //       onPressed: () {
            //         takePhoto(ImageSource.gallery);
            //       },
            //       label: const Text('Gallery',
            //           style: TextStyle(
            //               color: Colors.grey,
            //               fontFamily: 'Opensans',
            //               fontWeight: FontWeight.w400,
            //               fontSize: 16)),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
  
  bool validateName(String value) {
    return RegExp(r'^(?=.*?[a-zA-Z ]).{3,80}$')
        .hasMatch(value);
  }

}
