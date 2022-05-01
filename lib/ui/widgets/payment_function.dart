
import 'package:flutter/services.dart';
import 'package:part_wit/utils/ApiConstant.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String? message;
  bool? success;
  String? tokeId;

  StripeTransactionResponse({this.message, this.success,this.tokeId});
}

class StripeService {
  static CreditCard testCard = CreditCard(
    number: '4111111111111111',
    expMonth: 08,
    expYear: 22,
  );
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = ApiUrls.secretKey;

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: ApiUrls.publicKey,
        merchantId: ApiUrls.secretKey,
        androidPayMode: 'test'));
  }


  static Future<StripeTransactionResponse?> payWithNewCard(
      {String? amount, String? currency,String? cardNo,int? expMonth
        ,int? expYear,int? cvv}) async
  {
    try {
      var response = await StripePayment.createTokenWithCard(
        CreditCard(
          number: cardNo,
          expMonth: expMonth,
          expYear: expYear,
        ),
      );
      if(response !=null){
        return   StripeTransactionResponse(
            message: 'Transaction success', success: true,tokeId: response.tokenId.toString()
        );
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return   StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }


  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return   StripeTransactionResponse(message: message, success: false);
  }

}
