import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:lottie/lottie.dart';
import 'package:part_wit/data/socket_io_manager.dart';

import 'package:part_wit/model/message.dart';
import 'package:part_wit/provider/messages_provider.dart';
import 'package:part_wit/ui/routers/my_router.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/widgets/messages_form.dart';
import 'package:part_wit/ui/widgets/messages_item.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book18.dart';
import 'package:part_wit/utils/utility.dart';

import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String senderName;
  final String imgUrl;
  final String profileImg;

  const ChatScreen(this.imgUrl, this.senderName, this. profileImg);

  @override
  _ChatScreenState createState() => _ChatScreenState(imgUrl);
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController? _scrollController;

  late SocketIoManager _socketIoManager;

  bool _isTyping = false;
  String? _userNameTyping;
  final String imgUrl;

  _ChatScreenState( this.imgUrl);



  void _onTyping() {
    _socketIoManager.sendMessage(
        'typing', json.encode({'senderName': widget.senderName}));
  }

  void _onStopTyping() {
    _socketIoManager.sendMessage(
        'stop_typing', json.encode({'senderName': widget.senderName}));
  }



  void _sendMessage(String messageContent,String img) {

    _socketIoManager.sendMessage(
      'send_message',
      Message(
        widget.senderName,
        messageContent,
        img,
        widget.imgUrl,
        DateTime.now(),
      ).toJson(),
    );

    Provider.of<MessagesProvider>(context, listen: false)
        .addMessage(Message(widget.senderName, messageContent , img ,widget.imgUrl , DateTime.now()));
  }

 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    MessageForm(
      imgUrl,
      onSendMessage: _sendMessage,
      onTyping: _onTyping,
      onStopTyping: _onStopTyping,

    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky   ,overlays: [SystemUiOverlay.top]);
    super.initState();

    _scrollController = ScrollController();

    _socketIoManager = SocketIoManager(serverUrl: SERVER_URL)
      ..init()
      ..subscribe('receive_message', (Map<String, dynamic> data) {
        Provider.of<MessagesProvider>(context, listen: false)
            .addMessage(Message.fromJson(data));
        _scrollController!.animateTo(
          0.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
        );
      })
      ..subscribe('typing', (Map<String, dynamic> data) {
        _userNameTyping = data['senderName'];
        setState(() {
          _isTyping = true;
        });
      })
      ..subscribe('stop_typing', (Map<String, dynamic> data) {
        setState(() {
          _isTyping = false;
        });
      })
      ..connect();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _socketIoManager.disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: MyAppTheme.backgroundColor,
          brightness: Brightness.dark,
          centerTitle: true,
          title: Container(
            height: 70,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                CircleAvatar(
                  backgroundColor: MyAppTheme.buttonColor,
                  radius: 30,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                     widget.profileImg,

                    ),
                  ),
                ),
                  const SizedBox(width: 10,),
                  LightTextBodyFuturaPTBook18(data: widget.senderName,),

              ],),
            )

          ),
  //
          leading:
          Builder(
            builder: (context) => // Ensure Scaffold is in context
            // ignore: deprecated_member_use
            FlatButton(
                padding: const EdgeInsets.all(0.0),
                child: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                onPressed: () => {Utility.hideKeyboard(context), Get.back()}),
          ),
        ),
      ),
      // AppBar(
      //   title: Text(widget.senderName),
      // ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<MessagesProvider>(
              builder: (_, messagesProvider, __) => ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: messagesProvider.allMessages.length,
                itemBuilder: (ctx, index) => MessagesItem(
                  messagesProvider.allMessages[index],
                  messagesProvider.allMessages[index].isUserMessage(widget.senderName),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isTyping,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '$_userNameTyping is typing',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                  // Lottie.asset(
                  //   'assets/animations/chat-typing-indicator.json',
                  //   width: 40,
                  //   height: 40,
                  //   alignment: Alignment.bottomLeft,
                  // ),
                ],
              ),
            ),
          ),
          MessageForm(
            imgUrl,
            onSendMessage: _sendMessage,
            onTyping: _onTyping,
            onStopTyping: _onStopTyping,

          ),
        ],
      ),
    );
  }
}
