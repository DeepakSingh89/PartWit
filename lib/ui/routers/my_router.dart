import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:part_wit/ui/screens/about_partwit.dart';
import 'package:part_wit/ui/screens/add_items_screen.dart';
import 'package:part_wit/ui/screens/change_password.dart';
import 'package:part_wit/ui/screens/create_profile_screen.dart';
import 'package:part_wit/ui/screens/forgotpsw_screen.dart';
import 'package:part_wit/ui/screens/home_filter_products.dart';
import 'package:part_wit/ui/screens/home_filters_screen.dart';
import 'package:part_wit/ui/screens/home_item_details.dart';
import 'package:part_wit/ui/screens/home_screen.dart';
import 'package:part_wit/ui/screens/items_listed_for_sale.dart';
import 'package:part_wit/ui/screens/location_screen.dart';
import 'package:part_wit/ui/screens/login_screen.dart';
import 'package:part_wit/ui/screens/notifications.dart';
import 'package:part_wit/ui/screens/plan_screen.dart';
import 'package:part_wit/ui/screens/privacypolicy.dart';
import 'package:part_wit/ui/screens/home_pages/profile_screen.dart';
import 'package:part_wit/ui/screens/reset_new_password.dart';
import 'package:part_wit/ui/screens/save_items_screen.dart';
import 'package:part_wit/ui/screens/seller_all_review_screen.dart';
import 'package:part_wit/ui/screens/seller_review_screen.dart';
import 'package:part_wit/ui/screens/settings.dart';
import 'package:part_wit/ui/screens/signup_screen.dart';
import 'package:part_wit/ui/screens/splash_screen.dart';
import 'package:part_wit/ui/screens/termscondition.dart';
import 'package:part_wit/ui/screens/user_edit_profile.dart';
import 'package:part_wit/ui/screens/verification_forget_password_screen.dart';
import 'package:part_wit/ui/screens/verification_screen.dart';
import 'package:part_wit/ui/screens/welcom_screen.dart';
import 'package:part_wit/ui/screens/your_review.dart';
import 'package:part_wit/ui/widgets/messages_form.dart';

class MyRouter {
  static var homeScreen = "/homeScreen";
  static var locationScreen = "/location";
  static var loginScreen = "/login";
  static var signupScreen = "/signup";
  static var resetNewPasswordScreen = "/resetNewPassword";
  static var verificationScreen = "/verificationScreen";
  static var verificationForgetPasswordScreen = "/verificationForgetPasswordScreen";
  static var createProfile = "/createProfile";
  static var welcomeScreen = "/welcomeScreen";
  static var forgotPassword = "/forgotPassword";
  static var userProfile = "/userProfile";
  static var saveItems = "/saveItems";
  static var editProfile = "/editProfile";
  static var yourReview = "/yourReview";
  static var aboutPartWit = "/aboutPartWit";
  static var settings = "/settings";
  static var changePassword = "/changePassword";
  static var privacypolicy = "/privacypolicy";
  static var termscondition = "/termscondition";

  static var notification = "/notification";
  static var planScreen = "/planScreen";
  static var itemsListedForSale = "/itemsListedForSale";
  static var homeItemsDetails = "/homeItemsDetails";
  static var sellerAllReviewScreen = "/sellerAllReviewScreen";
  static var sellerReviewScreen = "/sellerReviewScreen";
  static var addItemsScreen = "/addItemsScreen";
  static var homeFiltersScreen = "/homeFiltersScreen";
  static var homeFilterProducts = "/homeFilterProducts";
  static var messageForm = "/messageForm";


  static var route = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: MyRouter.homeScreen, page: () => const HomeScreen(0)),
    GetPage(name: MyRouter.locationScreen, page: () => const LocationScreen()),
    GetPage(name: MyRouter.loginScreen, page: () => const LoginScreen()),
    GetPage(name: MyRouter.signupScreen, page: () => const SignUpScreen()),
    GetPage(name: MyRouter.verificationForgetPasswordScreen, page: () =>  VerificationForgetPasswordScreen("","")),
    GetPage(name: MyRouter.verificationScreen, page: () =>  VerificationScreen("","", "")),
    GetPage(name: MyRouter.createProfile, page: () => CreateProfile("", "")),
    GetPage(name: MyRouter.welcomeScreen, page: () => const WelcomeScreen()),
    GetPage(name: MyRouter.forgotPassword, page: () => const ForgotPassword()),
    GetPage(name: MyRouter.resetNewPasswordScreen, page: () =>  ResetNewPassword(email: '',)),
    GetPage(name: MyRouter.userProfile, page: () => const UserProfile()),
    GetPage(name: MyRouter.saveItems, page: () => const SaveItems()),
    GetPage(name: MyRouter.editProfile, page: () => const EditProfile()),
    GetPage(name: MyRouter.yourReview, page: () => const YourReview()),
    GetPage(name: MyRouter.aboutPartWit, page: () => const AboutPartWit()),
    GetPage(name: MyRouter.settings, page: () => const Settings()),
    GetPage(name: MyRouter.privacypolicy, page: () => const Privacypolicy()),
    GetPage(name: MyRouter.termscondition, page: () => const TermsCondition()),
    GetPage(name: MyRouter.changePassword, page: () => const ChangePassword()),

    GetPage(name: MyRouter.notification, page: () => const Notification()),
    GetPage(name: MyRouter.planScreen, page: () => const PlanScreen()),
    GetPage(name: MyRouter.itemsListedForSale, page: () => const ItemsListedForSale()),
    GetPage(name: MyRouter.homeItemsDetails, page: () =>   const HomeItemsDetails()),
    GetPage(name: MyRouter.sellerAllReviewScreen, page: () => const SellerAllReviewScreen()),
    GetPage(name: MyRouter.sellerReviewScreen, page: () => const SellerReviewScreen()),
    GetPage(name: MyRouter.addItemsScreen, page: () => const AddItemsScreen()),
    GetPage(name: MyRouter.homeFiltersScreen, page: () => const HomeFiltersScreen()),
    GetPage(name: MyRouter.homeFilterProducts, page: () => const HomeFilterProducts()),
    ///GetPage(name: MyRouter.messageForm, page: () =>  const MessageForm()),


  ];
}
