import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/provider/ChatListProvider.dart';
import 'package:part_wit/ui/screens/chat/chat.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_circle_logo.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_heavy18.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:provider/provider.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book12.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book20_yellow.dart';


class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    setState(() {
      Helpers.verifyInternet().then((intenet) {
        if (intenet) {
          WidgetsBinding.instance!.addPostFrameCallback(
                  (_) => {getChatList(  context)});
        } else {
          Helpers.createSnackBar(
              context, "Please check your internet connection");
        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Consumer<ChatListProvider>(
      builder: (BuildContext context, modal, Widget? child) {
      return modal.loading
          ? modal.chatListData.data != null &&
          modal.chatListData.data!.isNotEmpty
          ? ListView.builder(
        itemCount:  modal.chatListData.data!.length,
        itemBuilder: (BuildContext context, int index) => Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
            child: Material(
              elevation: 0.0,
              borderRadius: BorderRadius.circular(0.0),
              color: MyAppTheme.whiteColor,

                 child:  Column(
                   children: [
                     InkWell(
                       onTap: (){
                         Navigator.of(context).push(
                             MaterialPageRoute(
                               builder: (ctx) => ChatScreen('',modal.chatListData.data![index].name!,modal.chatListData.data![index].profilePic!,),
                             ),
                         );
                       },
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Row(
                           children: [
                               CircleAvatar(
                               backgroundColor: MyAppTheme.buttonColor,
                               radius: 35,
                               child: CircleAvatar(
                                 radius: 35,
                                 backgroundImage: NetworkImage(
                                   modal.chatListData.data![index].profilePic!,

                                 ),
                               ),
                             ),
                             SizedBox(width: screenSize.width*0.02,),

                             Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 LightTextBodyYellowFuturaPTBook20(data: modal.chatListData.data![index].name!,),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 2),
                                   child: LightTextBodyFuturaPTBook15(data: 'interested'.tr,),
                                 ),
                               ],
                             ),
                             const Spacer(),
                             // Column(
                             //   mainAxisAlignment: MainAxisAlignment.center,
                             //   crossAxisAlignment: CrossAxisAlignment.center,
                             //   children: [
                             //     SizedBox(height: screenSize.height*0.03,),
                             //     const LightTextBodyFuturaPTBook12(data: '7:02pm',),
                             //     CustomCircle( key: _globalKey,  data: '2',)
                             //   ],)

                           ],
                         ),
                       ),
                     ),
                     const Divider(
                       color: MyAppTheme.dividerColor,
                     )
                   ],
                 ),

            )),
      )  : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: LightTextBodyFuturaPTHeavy18(
                  data: 'noRecord'.tr)),
        ],
      )
          : const SizedBox(
          width: 20,
          height: 20,
          child: LightTextBodyFuturaPTHeavy18(data: ''));
      })),
    );
  }

  getChatList(BuildContext context) {
    Provider.of<ChatListProvider>(context, listen: false).loading = false;
    Provider.of<ChatListProvider>(context, listen: false)
        .chatList(  context);
  }
}
