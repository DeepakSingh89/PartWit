import 'dart:convert';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:part_wit/model/message.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';

class MessagesItem extends StatelessWidget {
  final Message _message;

  final bool isUserMassage;

  const MessagesItem(this._message, this.isUserMassage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection:
                isUserMassage ? TextDirection.rtl : TextDirection.ltr,
            children: <Widget>[
              isUserMassage
                  ? SizedBox()
                  : Card(
                      elevation: 2.0,
                      color: isUserMassage
                          ? MyAppTheme.backgroundColor.withOpacity(.8)
                          : MyAppTheme.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(isUserMassage ? 20 : 0),
                          bottomLeft: Radius.circular(isUserMassage ? 0 : 20),
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        child: Text(
                          _message.senderName.substring(0, 1).toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
              Column(
                crossAxisAlignment: isUserMassage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  isUserMassage
                      ? SizedBox()
                      : Container(
                          padding: isUserMassage
                              ? const EdgeInsets.only(right: 15)
                              : const EdgeInsets.only(left: 15),
                          child: FittedBox(
                            child: Text(
                              _message.senderName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.black.withOpacity(.6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Align(
                      alignment: isUserMassage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        elevation: 2.0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(isUserMassage ? 20 : 0),
                            bottomRight:
                                Radius.circular(isUserMassage ? 0 : 20),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          color: isUserMassage
                              ? MyAppTheme.buttonColor.withOpacity(.8)
                              : MyAppTheme.buttonColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _message.img.isNotEmpty
                                  ? Column(
                                      children: [
                                        if (_message.img.length < 200) ...[
                                          Image.network(
                                            _message.imgUrl,
                                          )
                                        ] else ...[
                                          Image.memory(const Base64Decoder()
                                              .convert(_message.img))
                                        ]
                                      ],
                                    )
                                  : Text(
                                      _message.content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReadMoreText(
                                DateFormat('h:mma')
                                    .format(_message.date)
                                    .toString(),
                                  trimLines: 2,
                                colorClickableText: Colors.yellow,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '...Show more',
                                trimExpandedText: ' show less',
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(.9),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
