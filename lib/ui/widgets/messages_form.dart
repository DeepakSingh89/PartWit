import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_grey_futura_book25.dart';
import 'package:part_wit/utils/utility.dart';

class MessageForm extends StatefulWidget {
  final Function(String,String)? onSendMessage;


   final Function? onTyping;

  final Function? onStopTyping;
  String img;

    MessageForm(this.img,   {
    @required this.onSendMessage,
    @required this.onTyping,
    @required this.onStopTyping,

  });

  @override
  _MessageFormState createState() => _MessageFormState(img);
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController? _textEditingController;

  String img;
  Timer? _typingTimer;

  bool _isTyping = false;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _MessageFormState(this.img);


  void _sendMessage() {
    if (_textEditingController!.text.isEmpty ) return;

    widget.onSendMessage!(_textEditingController!.text,'');

    setState(() {
      _textEditingController!.text = "";
    });
  }
  void _sendImg(String img) {
    if (img.isEmpty ) return;

    widget.onSendMessage!('',Utility.StringToEncode(img));

    setState(() {
      img = "";
    });
  }

  void _sendImgUrl(String img) {
    if (img.isEmpty ) return;


    widget.onSendMessage!('',img);

    setState(() {
      img = "";
    });
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


  void _runTimer() {
    if (_typingTimer != null && _typingTimer!.isActive) _typingTimer!.cancel();
    _typingTimer = Timer(Duration(milliseconds: 600), () {
      if (!_isTyping) return;
      _isTyping = false;
      widget.onStopTyping!();
    });
    _isTyping = true;
    widget.onTyping!();
  }

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('test img ${img.length}');
    if ( img.isNotEmpty && img.length>0)
    {
      print('test @1@@img ${img.length}');
      setState(() {
        _sendImgUrl(img);
      });

      print('test @@img ${img.length}');

    }

  }

  @override
  void dispose() {
    _textEditingController!.dispose();
    super.dispose();
  }
  bool isLoad  = true;
  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.grey.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[

            Container(
              child: IconButton(
                onPressed: openSheet ,
                icon:  SvgPicture.asset(
                  MyImages.icAddImg,
                  alignment: Alignment.centerLeft,
                  allowDrawingOutsideViewBox: false,
                ),
                color: Theme.of(context).primaryColor,
                iconSize: 35,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (_) {
                    _runTimer();
                  },
                  onSubmitted: (_) {
                    _sendMessage();

                  },
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              child: IconButton(
                onPressed: _sendMessage,
                icon:  SvgPicture.asset(
                  MyImages.icSend,
                  alignment: Alignment.centerRight,
                  allowDrawingOutsideViewBox: false,
                ),
                color: Theme.of(context).primaryColor,
                iconSize: 35,
              ),
            ),
          ],
        ),
      ),
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
      _sendImg(_imageFile.path);
      Navigator.pop(context);
    } on Exception catch (_) {}
  }
}
