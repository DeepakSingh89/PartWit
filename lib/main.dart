import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:part_wit/controller/binding_controller.dart';
import 'package:part_wit/provider/AboutPartWitProvider.dart';
import 'package:part_wit/provider/AllCardListProvider.dart';
import 'package:part_wit/provider/AttributesProvider.dart';
import 'package:part_wit/provider/CategoryListedForSaleProvider.dart';
import 'package:part_wit/provider/ChatListProvider.dart';
import 'package:part_wit/provider/EditProductProvider.dart';
import 'package:part_wit/provider/FliterProvider.dart';
import 'package:part_wit/provider/HomeDetailsProvider.dart';
import 'package:part_wit/provider/HomeFilterProductProvider.dart';
import 'package:part_wit/provider/HomeListProvider.dart';
import 'package:part_wit/provider/ItemsCategoryProvider.dart';
import 'package:part_wit/provider/NotificationProvider.dart';
import 'package:part_wit/provider/PrivacyPolicyProvider.dart';
import 'package:part_wit/provider/ProductByCategoryProvider.dart';
import 'package:part_wit/provider/ReasonProvider.dart';
import 'package:part_wit/provider/SavedItemsProvider.dart';
import 'package:part_wit/provider/SearchProvider.dart';
import 'package:part_wit/provider/SellerProfileProvider.dart';
import 'package:part_wit/provider/SellerRecentItemsProvider.dart';
import 'package:part_wit/provider/SellerReviewsProvider.dart';
import 'package:part_wit/provider/SubscriptionProvider.dart';
import 'package:part_wit/provider/TermsConditionsProvider.dart';
import 'package:part_wit/provider/ToastProvider.dart';
import 'package:part_wit/provider/WelecomPartwitProvider.dart';
import 'package:part_wit/provider/itemsListedForSaleProvider.dart';
import 'package:part_wit/provider/messages_provider.dart';
import 'package:part_wit/ui/styles/locale_string%20.dart';
import 'package:provider/provider.dart';
import 'ui/routers/my_router.dart';


void main() {
  BindingController().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    services.SystemChrome.setPreferredOrientations([
      services.DeviceOrientation.portraitUp,
      services.DeviceOrientation.portraitDown,
    ]);
    return
      MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: HomeListProvider() ),
            ChangeNotifierProvider.value(value: HomeDetailsProvider() ),
            ChangeNotifierProvider.value(value: ProductByCateProvider() ),
            ChangeNotifierProvider.value(value: SellerReviewProvider() ),
            ChangeNotifierProvider.value(value: ReasonListProvider() ),
            ChangeNotifierProvider.value(value: TermsConditionProvider() ),
            ChangeNotifierProvider.value(value: PrivacyPolicyProvider() ),
            ChangeNotifierProvider.value(value: AboutPartWitProvider() ),
            ChangeNotifierProvider.value(value: SubscriptionPlanProvider() ),
            ChangeNotifierProvider.value(value: SellerRecentItemsProvider() ),
            ChangeNotifierProvider.value(value: SavedItemsProvider() ),
            ChangeNotifierProvider.value(value: NotificationProvider() ),
            ChangeNotifierProvider.value(value: CategoryListedForSaleProvider() ),
            ChangeNotifierProvider.value(value: ItemsListedForSaleProvider() ),
            ChangeNotifierProvider.value(value: SearchProvider() ),
            ChangeNotifierProvider.value(value: ToastProvider() ),
            ChangeNotifierProvider.value(value: AttributeProvider() ),
            ChangeNotifierProvider.value(value: SellerProfileProvider() ),
            ChangeNotifierProvider.value(value: EditProductProvider() ),
            ChangeNotifierProvider.value(value: FilterProvider() ),
            ChangeNotifierProvider.value(value: HomeFilterProductProvider() ),
            ChangeNotifierProvider.value(value: MessagesProvider() ),
            ChangeNotifierProvider.value(value: ChatListProvider() ),
            ChangeNotifierProvider.value(value: WelcomePartWitProvider() ),


         //  ChangeNotifierProvider.value(value: PlanProvider() ),

          ],
         child: GetMaterialApp(
          translations: LocaleString(),
          locale: const Locale('en', 'US'),
          // fallbackLocale: const Locale('en', 'US'),
          //locale: DevicePreview.of(context).locale,
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'PartWit',
          getPages: MyRouter.route,

    ),
       );
  }
}
