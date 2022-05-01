import '../../ui/styles/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../routers/my_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationToWelcomeScreen);
  }

  void navigationToWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String id = prefs1.getString('id') ?? '';
    if (_seen) {
      if (id == '') {
        Navigator.pushReplacementNamed(context, MyRouter.locationScreen);
      } else {
        Navigator.pushReplacementNamed(context, MyRouter.homeScreen);
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushReplacementNamed(context, MyRouter.locationScreen);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: MyAppTheme.backgroundColor),
    );

    // var android =
    //     const AndroidInitializationSettings('mipmap/app_notification');
    // var ios = const IOSInitializationSettings();
    // firebaseCloudMessaging_Listeners();
    _startTime();
  }

  // void firebaseCloudMessaging_Listeners() async {
  //   await Firebase.initializeApp();
  //   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   _firebaseMessaging.getToken().then((token) {
  //     print("token : ${token}");
  //     MySingleton.shared.deviceToken = token!;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/partwit_splash.png'),
          fit: BoxFit.cover,
        )),
      )),
    );
  }
}
