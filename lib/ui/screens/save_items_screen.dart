import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/SaveItemCustomModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/provider/SavedItemsProvider.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/screens/seller_review_dialog.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book13_white.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book23.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_light11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium20.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium28.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:get/get_core/src/get_main.dart';

class SaveItems extends StatefulWidget {
  const SaveItems({Key? key}) : super(key: key);

  @override
  State<SaveItems> createState() => _SaveItemsState();
}

class _SaveItemsState extends State<SaveItems> {
  final _key = GlobalKey<FormState>();
  List<Model?> itemList=[];
  @override
  void initState() {
    super.initState();
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => {

              //  getSavedItemsList(context)
           ApiServices. saveItemsList(context).then((response) {
             print('##### ${response!.data!.length}');
             print('##### ${response.status}');
                  if(response.status == true)
               {
                itemList.clear();
                 for (var i = 0; i < response.data!.length; i++){
                   print('${response.data![i].id}');
                   setState(() {
                     itemList.add(Model( response.data![i].id,response.data![i].productId,response.data![i].userId,response.data![i].productName,response.data![i].price,response.data![i].date,response.data![i].featuredImage,));

                   });
                     }
               }
           })

              });
        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });
  }

  void _removeImg(int index, String id, BuildContext context,) async {

      itemList.removeAt(index);
      if(id !=null){
        ApiServices.removeSavedItem(
            id, context);
      }


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: Utility.actionBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: LightTextBodyFuturaPTMedium20(
                data: 'Saved Items'.tr,
              ),
            ),
            Expanded(
              child:
              // Consumer<SavedItemsProvider>(
              //     builder: (BuildContext context, modal, Widget? child) {
              //   return modal.loading
              //       ? modal.savedItems.data != null &&modal.savedItems.data!.isNotEmpty
            // ?
          itemList!= null && itemList.isNotEmpty ?  ListView.builder(
                            itemCount: itemList.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 1),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Material(
                                          elevation: 0.0,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: itemList[index]!.featured_image !=
                                                              null &&
                                                      itemList[index]!.featured_image.isNotEmpty
                                                      ?

                                                  Image.network(

                                                    itemList[index]!.featured_image,
                                                      width: 100,
                                                      height: 100,
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
                                                      },
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                      return Utility.placeHolder();
                                                    },
                                                      )

                                                      : Utility.placeHolder()),
                                              Flexible(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [

                                                            SizedBox(
                                                              width: 120.0,
                                                              child:  LightTextBodyFuturaPTMedium18(
                                                                data:itemList[index]!.product_name,
                                                              ),
                                                            ),

                                                            LightTextBodyFuturaPTLight11(
                                                              data: Utility
                                                                  .dateFormatter( itemList[index]!.date
                                                                      ), //Constant.DATE,
                                                            ),
                                                          ],
                                                        ),
                                                        LightTextBodyFuturaPTMedium18(
                                                          data: "\$ " +
                                                              itemList[index]!.price
                                                                  .toString(), //Constant.DOLLAR,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenSize.height *
                                                              0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            try {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return SellerReviewDailog(
                                                                      itemList[index]!.featured_image,
                                                                      itemList[index]!.user_id

                                                                          .toString(),
                                                                    );
                                                                  });
                                                            } on Exception catch (e) {
                                                              e.printError();
                                                            }
                                                          },
                                                          child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              width: screenSize
                                                                      .width *
                                                                  0.40,
                                                              height: screenSize
                                                                      .height *
                                                                  0.05,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25)),
                                                                child:
                                                                    Container(
                                                                  color: MyAppTheme
                                                                      .buttonColor,
                                                                  child: Center(
                                                                    child:
                                                                        LightTextBodyWhiteFuturaPTBook13(
                                                                      data: 'reviewSeller'
                                                                          .tr,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ) // This trailing comma makes auto-formatting nicer for build methods.
                                                              ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenSize.width *
                                                                  0.10,
                                                        ),
                                                        Flexible(
                                                          child: InkWell(
                                                              onTap: () {
                                                                showAlertDialog(
                                                                    itemList[index]!.id.toString(),
                                                                    context,index);
                                                              },
                                                              child: Image.asset(
                                                                  MyImages
                                                                      .icDelete)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: LightTextBodyFuturaPTHeavy18(
                                      data: 'noRecord'.tr)),
                            ],
                          )

             // }),
            )
          ],
        ),
      ),
    );
  }

  getSavedItemsList(BuildContext context) {
    Provider.of<SavedItemsProvider>(context, listen: false).loading = false;

    Provider.of<SavedItemsProvider>(context, listen: false)
        .savedItemsList(context);
  }

  showAlertDialog(String id, BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: ()   {
        try {
          Navigator.of(context).pop();
          // Provider.of<SavedItemsProvider>(context, listen: false).loading;
          // Provider.of<SavedItemsProvider>(context, listen: false)
          //     .removeItemsList(id, context);
          _removeImg(index,id,context);
          // ApiServices.removeSavedItem(
          //     id, context).then((value) {
          //   // if(value.status== true){
          //   //   Provider.of<SavedItemsProvider>(context, listen: false).savedItemsList(context) ;
          //   // }
          //
          // });
          setState(() {

          });
        } on Exception catch (e) {
          e.printError();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Are you sure want to Delete?"),
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
}
