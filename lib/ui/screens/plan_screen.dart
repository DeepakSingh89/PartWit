import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/AllCardListModel.dart';
import 'package:part_wit/model/SubscriptionPlanModel.dart';
import 'package:part_wit/network/ApiServices.dart';
import 'package:part_wit/payments/cardinputvalidation.dart';
import 'package:part_wit/payments/payment_function.dart';
import 'package:part_wit/payments/paymentcard.dart';
import 'package:part_wit/provider/AllCardListProvider.dart';
import 'package:part_wit/provider/SubscriptionProvider.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/ui/widgets/custom_button.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_bold18.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book11.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book15.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book24.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium16.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_medium18.dart';
import 'package:part_wit/utils/Helpers.dart';
import 'package:part_wit/utils/constant.dart';
import 'package:part_wit/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:part_wit/model/AllCardListModel.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  String? textHolder = 'getFree'.tr;

  var numberController = TextEditingController();
  var _paymentCard = PaymentCard();
  var monthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var _autoValidate = false;
  bool isLoadApi = true;
  bool isVisible = true;
  bool isVisible_ = false;
  Map? rcvdData;

  @override
  void initState() {
    StripeService.init();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    try {
      rcvdData = ModalRoute.of(context)!.settings.arguments as Map;
    } on Exception catch (e) {
      e.printError();
    }

    if (isLoadApi == true) {
      isLoadApi = false;

      if (rcvdData!['type'] == Constant.FEATURED) {
        setState(() {
          textHolder = 'getFP'.tr;
          isVisible_ = false;
          isVisible = true;
          plans(rcvdData!['type'].toString());
        });
      } else {
        setState(() {
          isVisible_ = true;
          isVisible = false;
          plans('');
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: Utility.actionBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(child: Image.asset(MyImages.imgPlan)),
              Offstage(
                offstage: isVisible,
                child: LightTextBodyFuturaPTBook24(
                  data: 'upgradePlan'.tr,
                ),
              ),
              Offstage(
                offstage: isVisible_,
                child: LightTextBodyFuturaPTBook24(
                  data: 'upgradeToFeatured'.tr,
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              LightTextBodyFuturaPTBook15(
                data: 'makeFeature'.tr,
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Consumer<SubscriptionPlanProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.subscriptionPlansData.data != null &&
                            modal.subscriptionPlansData.data!.isNotEmpty
                        ? Flexible(
                            child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height * 0.15),
                            child: ListView.builder(
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    modal.subscriptionPlansData.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: _premiumPlan(
                                          modal.subscriptionPlansData
                                              .data![index],
                                          screenSize,
                                          index,
                                          modal,
                                          modal.subscriptionPlansData));
                                }),
                          ))
                        : Center(
                            child: LightTextBodyFuturaPTBook16(
                                data: 'noSubscriptionPlan'.tr),
                          )
                    : Container();
              }),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Consumer<SubscriptionPlanProvider>(
                  builder: (BuildContext context, modal, Widget? child) {
                return modal.loading
                    ? modal.allCardsData.data != null &&
                            modal.allCardsData.data!.data!.isNotEmpty
                        ? Flexible(
                            child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height * 0.20),
                            child: ListView.builder(
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    modal.allCardsData.data!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: _card(
                                            modal.allCardsData.data!
                                                .data![index],
                                            index),
                                      ));
                                }),
                          ))
                        : Center(
                            child:
                                LightTextBodyFuturaPTBook16(data: 'noCard'.tr),
                          )
                    : Container();
              }),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              InkWell(
                onTap: () {
                  numberController.clear();
                  monthController.clear();
                  _paymentMethodBottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: screenSize.height * 0.07,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.add_circle_outline),
                        LightTextBodyFuturaPTMedium18(data: 'addCard'.tr)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Consumer<SubscriptionPlanProvider>(
                builder: (context, modal, child) {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    height: screenSize.height * 0.1,
                    width: screenSize.width * 1,
                    child: CustomButton(
                      '$textHolder',
                      50,
                      onPressed: () {
                        if (rcvdData!['type'] == Constant.FEATURED) {
                          if (modal.isSelectedCard == -1) {
                            Helpers.createSnackBar(context, 'selectCard'.tr);
                          } else {
                            Provider.of<SubscriptionPlanProvider>(context,
                                    listen: false)
                                .payment(context, modal.cardId.toString(), "1",
                                    modal.selectedPlanId.toString());
                          }
                        } else {
                          if (modal.isSelectedValue == 0) {
                            Helpers.createSnackBar(context, 'youHave'.tr);
                          } else if (modal.isSelectedCard == -1) {
                            Helpers.createSnackBar(context, 'selectCard'.tr);
                          } else {
                            Provider.of<SubscriptionPlanProvider>(context,
                                    listen: false)
                                .payment(context, modal.cardId.toString(), "1",
                                    modal.selectedPlanId.toString());
                          }
                        }
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Offstage(
                offstage: isVisible,
                child: Column(
                  children: [
                    LightTextBodyFuturaPTMedium16(data: 'subscription'.tr),
                    SizedBox(
                      height: screenSize.height * 0.01,
                    ),
                    LightTextBodyFuturaPTBook16(
                        data: 'subscription_disable'.tr),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                      child: LightTextBodyFuturaPTBook16(
                          data: 'subscription_disable1'.tr),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _premiumPlan(
      Datum data,
      Size screenSize,
      int index,
      SubscriptionPlanProvider modal,
      SubscriptionPlanModel subscriptionPlansData) {
    return InkWell(
        onTap: () {
          setState(() {
            setText(data, index, subscriptionPlansData);

          });

          modal.selectPlan(index);
        },
        child: Container(
            width: screenSize.width * 0.28,
            height: screenSize.height * 0.18,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                  color: modal.isSelectedValue == index
                      ? MyAppTheme.backgroundColor
                      : MyAppTheme.box_bg_grayColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 25, 9),
                        child: Align(
                          child: LightTextBodyFuturaPTBook15(
                            data: data.subscriptionType!,
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width * 0.27,
                        height: screenSize.height * 0.10,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: Container(
                            color: MyAppTheme.items_bg_Color,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LightTextBodyFuturaPTBold18(
                                  data: '\$' + data.price!,
                                ),
                                SizedBox(
                                  height: screenSize.height * 0.02,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: LightTextBodyFuturaPTBook11(
                                    data: Utility.parseHtmlString(
                                        data.description!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ) // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }

  getSubscriptionPlanList(String type, BuildContext context) {
    Provider.of<SubscriptionPlanProvider>(context, listen: false).loading =
        false;
    Provider.of<SubscriptionPlanProvider>(context, listen: false)
        .subscriptionPlan(type, context);
    Provider.of<SubscriptionPlanProvider>(context, listen: false)
        .allCardList(context);
  }

  _paymentMethodBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: screenSize.height * 0.7,
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _paymentText(),
                    const SizedBox(
                      height: 50,
                    ),
                    _cardNumber(),
                    _cardCvvAndValidDate(screenSize),
                    const SizedBox(
                      height: 20,
                    ),
                    _payButton(screenSize),
                  ],
                ),
              ),
            ),
          );
        });
  }

// Payment Text
  _paymentText() {
    return LightTextBodyFuturaPTMedium18(data: 'payment'.tr);
  }

// Card
  _cardNumber() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LightTextBodyFuturaPTBook16(data: 'cardNo'.tr),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card_outlined,
                size: 40,
                color: Colors.grey[700],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                child: TextFormField(
                  onSaved: (String? value) {
                    _paymentCard.number = CardUtils.getCleanedNumber(value!);
                    setState(() {
                      _paymentCard.number = value;
                    });
                  },
                  onChanged: (String? val) {
                    final val = TextSelection.collapsed(
                        offset: numberController.text.length);
                    numberController.selection = val;
                  },
                  controller: numberController,
                  validator: CardUtils.validateCardNum,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black87),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: 'XXXX XXXX XXXX XXXX',
                    focusedBorder: _inputBorder,
                    enabledBorder: _inputBorder,
                    border: _inputBorder,
                    focusedErrorBorder: _inputBorder,
                    fillColor: Colors.grey[300],
                    errorBorder: _inputBorder,
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 14.0),
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void validate() async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    try {
      final FormState? form = _formKey.currentState;
      if (!form!.validate()) {
        setState(() {
          _autoValidate = true;
        });
      } else {
        form.save();
        Navigator.pop(context);


        var response = await StripeService.payWithNewCard(
          cardNo: _paymentCard.number!.trim(),
          expMonth: _paymentCard.month,
          expYear: _paymentCard.year,
        );
        print('card resss :  ${response!.success!}');
        print('card token:  ${response.tokeId!}');
        if (response != null) {
          if (response.success!) {
            Provider.of<SubscriptionPlanProvider>(context, listen: false)
                .addCard(context, response.tokeId!);
          } else if (response.success == false) {
            //  Helpers.hideLoader(loader);
            Helpers.createSnackBar(context, 'invalidCard'.tr);
          } else {
            //  Helpers.hideLoader(loader);
            Helpers.createSnackBar(context, 'somethingWrong'.tr);
          }
        } else {
          // Helpers.hideLoader(loader);
          Helpers.createSnackBar(context, 'invalidCard'.tr);
        }
      }
    } catch (exception) {
      //   Helpers.hideLoader(loader);
      Helpers.createSnackBar(context, 'invalidCard'.tr);
      rethrow;
    }
  }

  // card cvv or card valid date
  _cardCvvAndValidDate(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LightTextBodyFuturaPTBook16(data: 'cvv'.tr),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: screenSize.width * 0.43,
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly,
                  //   LengthLimitingTextInputFormatter(4),
                  // ],
                  // validator: CardUtils.validateCVV,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    setState(() {
                      _paymentCard.cvv = int.parse(value!);
                    });
                  },
                  style: const TextStyle(color: Colors.black87),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: 'XXX',
                    focusedBorder: _inputBorder,
                    enabledBorder: _inputBorder,
                    border: _inputBorder,
                    focusedErrorBorder: _inputBorder,
                    fillColor: Colors.grey[300],
                    errorBorder: _inputBorder,
                    filled: true,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LightTextBodyFuturaPTBook16(data: 'expiry'.tr),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: screenSize.width * 0.43,
                child: TextFormField(
                  // validator: CardUtils.validateDate,
                  keyboardType: TextInputType.number,
                  controller: monthController,
                  onSaved: (value) {
                    List<int> expiryDate = CardUtils.getExpiryDate(value!);
                    setState(() {
                      _paymentCard.month = expiryDate[0];
                      _paymentCard.year = expiryDate[1];
                    });
                  },
                  onChanged: (String? val) {
                    final val = TextSelection.collapsed(
                        offset: monthController.text.length);
                    monthController.selection = val;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CardMonthInputFormatter()
                  ],
                  style: const TextStyle(color: Colors.black87),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    counterText: '',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: 'MM/YY',
                    focusedBorder: _inputBorder,
                    enabledBorder: _inputBorder,
                    border: _inputBorder,
                    focusedErrorBorder: _inputBorder,
                    fillColor: Colors.grey[300],
                    errorBorder: _inputBorder,
                    filled: true,
                    errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Payment Button
  _payButton(Size screenSize) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: MyAppTheme.backgroundColor,
      onPressed: () {
        validate();
      },
      child: !isLoading
          ? LightTextBodyFuturaPTMedium18(
              data: 'save'.tr,
            )
          : Utility.loadingIndicator(Colors.white),
      height: screenSize.height * 0.07,
      minWidth: screenSize.width * 0.4,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

// input border style
  final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    // borderSide: BorderSide(color: Color.grey[200], width: 1.0),
  );

  Widget _card(CardData data, int i) {
    return Consumer<SubscriptionPlanProvider>(
      builder: (context, modal, child) {
        return InkWell(
          onTap: () {
            print('#### ${data.brand}');
            print('#### ${i}');
            modal.selectCard(i);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data.brand != null
                  ? Expanded(
                      flex: 3,
                      child: Text(
                        data.brand.toString(),
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Text(''),
              Expanded(
                flex: 6,
                child: Text(data.last4 != null
                    ? 'XXXX XXXX XXXX ' + data.last4.toString()
                    : ''),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: modal.isSelectedCard == i
                      ? const Icon(Icons.radio_button_checked,
                          color: Colors.blue)
                      : const Icon(Icons.radio_button_unchecked,
                          color: Colors.grey),
                  onPressed: () {
                    modal.selectCard(i);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void plans(String type) {
    Helpers.verifyInternet().then((intenet) {
      if (intenet) {
        WidgetsBinding.instance!.addPostFrameCallback(
            (_) => {getSubscriptionPlanList(type, context)});
      } else {
        Helpers.createSnackBar(
            context, "Please check your internet connection");
      }
    });
  }

  void setText(
    Datum data,
    int index,
    SubscriptionPlanModel subscriptionPlansData,
  ) {
    textHolder =
        'getPlan'.tr + data.subscriptionType! + ' / ' + '\$ ' + data.price!;
  }

  void setTextdefault(
      Datum data, int index, SubscriptionPlanModel subscriptionPlansData) {
    if (rcvdData!['type'] == Constant.FEATURED) {
      if (index == 0) {
        textHolder = 'getPlan'.tr +
            subscriptionPlansData.data![0].subscriptionType! +
            ' / ' +
            '\$ ' +
            subscriptionPlansData.data![0].price!;
      }
    }
  }
}
