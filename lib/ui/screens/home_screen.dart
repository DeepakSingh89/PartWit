import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:part_wit/provider/AttributesProvider.dart';
import 'package:part_wit/provider/CategoryListedForSaleProvider.dart';
import 'package:part_wit/provider/HomeListProvider.dart';
import 'package:part_wit/provider/ProductByCategoryProvider.dart';
import 'package:part_wit/ui/screens/home_pages/home_page.dart';
import 'package:part_wit/ui/screens/home_pages/profile_screen.dart';
import 'package:part_wit/ui/screens/search_screen.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/widgets/custom_widgets/AppBar.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'add_items_screen.dart';
import 'chat_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen( int this.index);// : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(index);
}

class _HomeScreenState extends State<HomeScreen> {
  final int index;

    bool _isVisible=true;
  _HomeScreenState(this.index);

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  int _currentPage = 0;
  var isProfilePage = true;

  @override
  initState() {
    if (index == 4) {
      isProfilePage = false;
    }

    if(index == 2)
      {
        _isVisible=false;

      }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky   ,overlays: [SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom]);
    super.initState();
    _currentPage = index;


    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback((_) => {
            getCategoryItemsList(context),

          });
        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });

  }
  List<Widget> navigationPage = [
    const HomePage(),
    const SearchScreen(),
    const AddItemsScreen(),
    const ChatListScreen(),
    const UserProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          onTap: () {
            Utility.hideKeyboard(context);
          },
          child: Scaffold(
              appBar: _isVisible?buildAppBar(isProfilePage):null,
              body: SafeArea(
                child: navigationPage.elementAt(_currentPage),
              ),
              bottomNavigationBar: _createBottomNavigationBar())),
    );
  }

  Widget _createBottomNavigationBar() {
    return _isVisible?BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: MyAppTheme.backgroundColor,
      type: BottomNavigationBarType.fixed,
      unselectedIconTheme: const IconThemeData(color: Colors.white70),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      onTap: (int num) {
        _currentPage = num;

        setState(() {
          isProfilePage = _currentPage == 0 ? true : false;
          _isVisible=_currentPage==2?false:true;
        });
      },
      showSelectedLabels: false,
      currentIndex: _currentPage,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.add, size: 22), label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 20,
            ),
            label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
      ],
    ) : const AddItemsScreen();
  }


}
getCategoryItemsList(BuildContext context) {
  Provider.of<CategoryListedForSaleProvider>(context, listen: false).loading =
  false;
  ///add products
  Provider.of<CategoryListedForSaleProvider>(context, listen: false).catList(context);
 // Provider.of<AttributeProvider>(context, listen: false).attributesList('',context);
  ///

  Provider.of<HomeListProvider>(context, listen: false).HomeListItems(context);
  Provider.of<ProductByCateProvider>(context, listen: false)
      .ProductByCat('1', context);
}