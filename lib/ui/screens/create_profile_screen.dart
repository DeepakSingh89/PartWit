import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_wit/repository/update_user_profile_repository.dart';
import 'package:part_wit/repository/user_sign_up_repository.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/fonts.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';

import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book17.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light34.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_grey_futura_book25.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/my_app_theme.dart';
import 'package:part_wit/utils/utility.dart';

import 'package:permission_handler/permission_handler.dart';


class CreateProfile extends StatefulWidget {
  String email, password;

  CreateProfile(this.email, this.password, {Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState(email, password);
}

class _CreateProfileState extends State<CreateProfile> {
  String email, password;
  final profileFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _CreateProfileState(this.email, this.password);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (validateName(_nameController.text)) {
        profileFormKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Utility.hideKeyboard(context);
        },
        child: Scaffold(
          backgroundColor: MyAppTheme.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: profileFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.07,
                  ),
                  Center(
                    child: Image.asset(MyImages.ic_app_logo),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                    LightTextBodyFuturaPTHeavy34(
                    data: 'createProfile'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  imageProfile(context),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                    LightTextBodyFuturaPTBook17(
                    data: 'uploadProfile'.tr,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: TextFormField(
                      maxLength: 15,
                      style: const TextStyle(
                          color: MyAppTheme.textPrimary,
                          fontFamily: Fonts.futurPT,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),

                      obscureText: false,
                      focusNode: nameFocus,
                      controller: _nameController,
                      onTap: () {
                        setState(() {});
                      },
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
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        counterText: "",
                        errorMaxLines: 2,
                        fillColor: MyAppTheme.buttonShadow_Color,
                        hintText: 'yourName'.tr,
                        hintStyle: const TextStyle(
                            color: MyAppTheme.textPrimary,
                            fontFamily: Fonts.futurPT,
                            fontWeight: FontWeight.w100,
                            fontSize: 16),
                        prefixIcon: Image.asset(MyImages.ic_feather_user),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: MyAppTheme.buttonShadow_Color),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                            BorderSide(color: MyAppTheme.buttonShadow_Color),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0))),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: MyAppTheme.whiteColor, width: 2.0),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        CustomButton(
                          'continue'.tr,
                          54,
                          onPressed: () {
                            String uName= _nameController.text.trim();
                            if (_imageFile == null) {
                              Helpers.createSnackBar(context,
                                  "Please Upload your image first then proceed");
                            }
                            if (profileFormKey.currentState!.validate()) {
                              FocusScope.of(this.context).requestFocus(
                                  FocusNode());
                              if(uName.length>=3){
                                Helpers.verifyInternet().then((internet) {
                                  if (internet) {
                                    createRegistration(_imageFile!,
                                        email,
                                        _nameController.text.trim(),
                                        password,
                                        context
                                    ).then((value) => {
                                      if (value.status!) {
                                        //     Helpers.createSnackBar(context,
                                        //     "Please check your internet connection"),
                                        setState(() {
                                          Navigator.pushReplacementNamed(context, MyRouter.welcomeScreen);
                                        })
                                      }
                                    });
                                  } else {
                                    Helpers.createSnackBar(context,
                                        "Please check your internet connection");
                                  }
                                });
                              }else{
                                Utility.toast('Name must be greater than three characters');
                              }

                            }
                          },
                        ),
                      ],
                    ),
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
                child: getImageWidget(),
              )),
          Positioned(
            bottom: 0,
            right: 5,
            child: InkWell(
              onTap: () {
                openSheet();
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.blue,
                size: 25,
              ),
            ),
            // const Positioned(
            //   bottom: 0,
            //   right: 10,
            //   child:
            //   Material(
            //     color:Colors.white,
            //     shape: CircleBorder(),
            //     child:
            //     Icon(
            //       Icons.add_circle_outline,
            //       color: Colors.blue,
            //       size: 34,
            //     ),
            //   )
          ),
        ],
      )
      ,
    );
  }

  takePhoto(ImageSource source) async {
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

  void checkPermission() async {
    await _handleLocationPermission(Permission.camera);
    await _handleLocationPermission(Permission.photos);
  }

  Future<void> _handleLocationPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      Helpers.createSnackBar(context, "Permission Accessed");
      // Navigator.pushReplacementNamed(context,MyRouter.loginScreen);
    } else if (status.isDenied) {
      Helpers.createSnackBar(context, "Permission Denied");
    }
  }

  getImageWidget() {
    if (_imageFile != null) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 60,
        child: CircleAvatar(
          radius: 58.0,
          backgroundImage: Image
              .file(_imageFile!)
              .image,
        ),
      );
    } else {
      return const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 60,
          child: CircleAvatar(
            radius: 58,
            backgroundImage: AssetImage(MyImages
                .ic_person //Convert File type of image to asset image path),
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
    return Container(
      height:screenSize.height*0.30 ,
      width: screenSize.width,
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
                },
              ),
              ListTile(

                  title:   LightTextBodyFuturaPTBold18(data: 'gallery'.tr, ),
                  onTap: () {
                    takePhoto(ImageSource.gallery);
                  }),

              ListTile(
                title:   LightTextBodyFuturaPTBold18(data: 'cancel'.tr, ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool validateName(String value) {
    return RegExp(r'^(?=.*?[a-zA-Z ]).{3,15}$')
        .hasMatch(value);
  }

}
