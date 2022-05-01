import 'package:flutter/material.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

AppBar buildAppBar(isProfilePage) {
  return AppBar(
    // systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.orange),
    backgroundColor: MyAppTheme.backgroundColor,
    centerTitle: true,
    title: Container(
      height: 60,
      width: 50,
      alignment: Alignment.center,
      child: Image.asset(MyImages.ic_app_logo),
    ),
    leading: Builder(
        builder: (context) => Visibility(
              child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: SvgPicture.asset(
                    'assets/icons/notifications.svg',
                    height: 20,
                    width: 20,
                  ),
                  onPressed: () => {Get.toNamed(MyRouter.notification)}),
              visible: isProfilePage,
            )),
    actions: [
      Visibility(
        visible: isProfilePage,
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            Get.toNamed(MyRouter.homeFiltersScreen);
          },
        ),
      )
    ],
  );
}
