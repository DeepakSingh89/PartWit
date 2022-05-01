import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_wit/provider/HomeFilterProductProvider.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
class HomeFilterProducts extends StatefulWidget{
  const HomeFilterProducts({Key? key}) : super(key: key);


  @override
  State<HomeFilterProducts> createState() => _HomeFilterProductsState();
}

class _HomeFilterProductsState extends State<HomeFilterProducts> {
  bool isLoad = true;
  Map? rcvdData;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 4.4;
    final double itemWidth = size.width / 2;


    try {
      rcvdData = ModalRoute.of(context)!.settings.arguments as Map;
    } on Exception catch (e) {
      e.printError();
    }

    if (isLoad == true) {
      isLoad = false;
      setState(() {
        Helpers.verifyInternet().then((intenet) {
          if (intenet) {
            WidgetsBinding.instance!.addPostFrameCallback(
                    (_) => {getFilteredData(rcvdData!['category_id'].toString(),rcvdData!['att_val'] ,rcvdData!['year_from'].toString(),rcvdData!['year_to'].toString(),rcvdData!['min_price'].toString(),rcvdData!['max_price'].toString(),context),});
          } else {
            Helpers.createSnackBar(
                context, "Please check your internet connection");
          }
        });
      });
    }


   return SafeArea(
     child: Scaffold(
       appBar: Utility.actionBar(),
      body: SingleChildScrollView(
       child: Column(
         children: [
           const SizedBox(
             height: 30,
           ),
           Consumer<HomeFilterProductProvider>(
               builder: (BuildContext context, modal, Widget? child) {
                 return modal.loading
                     ? modal.homefilterData.data != null &&
                     modal.homefilterData.data!.length > 0
                     ? GridView.builder(
                   itemCount: modal.homefilterData.data!.length,
                   shrinkWrap: true,
                   primary: false,
                   gridDelegate:
                   SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     childAspectRatio: (itemWidth / itemHeight),
                   ),
                   itemBuilder: (BuildContext context, int index) {
                     return   InkWell(
                       onTap: () {
                         Get.toNamed(MyRouter.homeItemsDetails,
                             arguments: modal
                                 .homefilterData.data![index].id);
                       },
                       child: Container(
                         margin: const EdgeInsets.only(
                             left: 5,
                             right: 5,
                             top: 10,
                             bottom: 10),
                         child: Column(
                           crossAxisAlignment:
                           CrossAxisAlignment.center,
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           children: [
                             if (modal.homefilterData.data != null &&
                                 modal.homefilterData.data!.length >
                                     index)
                               Expanded(
                                 child: modal
                                     .homefilterData
                                     .data![index]
                                     .featuredImage !=
                                     null &&
                                     modal
                                         .homefilterData
                                         .data![index]
                                         .featuredImage!
                                         .isNotEmpty
                                     ?

                       Image.network(
                           modal
                               .homefilterData
                               .data![index]
                               .featuredImage!,
                           height: 140,
                           width: 160,
                           fit: BoxFit.cover,
                           loadingBuilder: (BuildContext
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
                           })


                                     : Image.asset(
                                   MyImages.noImgPlaceHolder,
                                   width: 100,
                                   height: 100,
                                 ),
                               ),
                             Padding(
                               padding: const EdgeInsets.only(
                                   left: 10, right: 10),
                               child: Row(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.center,
                                 mainAxisAlignment:
                                 MainAxisAlignment.spaceAround,
                                 children: [
                                   Column(
                                     mainAxisAlignment:
                                     MainAxisAlignment.start,
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: [


                                       SizedBox(
                                         width: 100.0,
                                         child: LightTextBodyFuturaPTMedium18(
                                           data: modal.homefilterData
                                               .data![index].name!,
                                         ),
                                       ),
                                       LightTextBodyFuturaPTLight11(
                                         data: modal.homefilterData
                                             .data![index].date!,
                                       ),
                                     ],
                                   ),
                                   SizedBox(
                                     width: 60.0,
                                     child: LightTextBodyFuturaPTMedium16(
                                       data: '\$' +
                                           modal.homefilterData
                                               .data![index].price!
                                               .toString(),
                                     ),
                                   ),
                                 ],
                               ),
                             )
                           ],
                         ),
                       ),
                     );
                   },
                 )
                     : Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children:   [
                     Center(
                         child: LightTextBodyFuturaPTHeavy18(data: modal.homefilterData.message!)),
                   ],
                 )
                     : const SizedBox(
                     width: 20,
                     height: 20,
                     child: LightTextBodyFuturaPTHeavy18(data: ' '));
               }),
         ],
       ),
     ),
     ));
  }

  getFilteredData(String category_id,  att_val, String year_from, String year_to, String min_price, String max_price, BuildContext context) {
    Provider.of<HomeFilterProductProvider>(context, listen: false).loading = false;
    Provider.of<HomeFilterProductProvider>(context, listen: false)
        .homeFilterProducts(category_id,att_val,year_from,year_to,min_price,max_price,context);
  }
}