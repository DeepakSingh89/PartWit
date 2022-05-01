
import 'dart:convert';

PaymentPoJo paymentPoJoFromJson(String str) => PaymentPoJo.fromJson(json.decode(str));

String paymentPoJoToJson(PaymentPoJo data) => json.encode(data.toJson());

class PaymentPoJo {
  PaymentPoJo({
    this.status,
    this.message,
    this.userInfo,
    this.data,
  });

  String? status;
  String? message;
  UserInfo? userInfo;
  Data? data;

  factory PaymentPoJo.fromJson(Map<String, dynamic> json) => PaymentPoJo(
    status: json["status"],
    message: json["message"],
    userInfo: UserInfo.fromJson(json["user_info"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user_info": userInfo!.toJson(),
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    this.captureMethod,
    this.charges,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.invoice,
    this.lastPaymentError,
    this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  int? amountReceived;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic automaticPaymentMethods;
  dynamic canceledAt;
  dynamic cancellationReason;
  String? captureMethod;
  Charges? charges;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  String? customer;
  dynamic description;
  dynamic invoice;
  dynamic lastPaymentError;
  bool? livemode;
  List<dynamic>? metadata;
  dynamic nextAction;
  dynamic onBehalfOf;
  String? paymentMethod;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  dynamic processing;
  dynamic receiptEmail;
  dynamic review;
  dynamic setupFutureUsage;
  dynamic shipping;
  dynamic source;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  String? transferGroup;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"]== null ? null : json["id"],
    object: json["object"]== null ? null : json["object"],
    amount: json["amount"]== null ? null : json["amount"],
    amountCapturable: json["amount_capturable"]== null ? null : json["amount_capturable"],
    amountReceived: json["amount_received"]== null ? null : json["amount_received"],
    application: json["application"]== null ? null : json["application"],
    applicationFeeAmount: json["application_fee_amount"]== null ? null : json["application_fee_amount"],
    automaticPaymentMethods: json["automatic_payment_methods"]== null ? null : json["automatic_payment_methods"],
    canceledAt: json["canceled_at"]== null ? null : json["canceled_at"],
    cancellationReason: json["cancellation_reason"]== null ? null : json["cancellation_reason"],
    captureMethod: json["capture_method"]== null ? null : json["capture_method"],
    charges: Charges.fromJson(json["charges"]== null ? null : json["charges"],),
    clientSecret: json["client_secret"]== null ? null : json["client_secret"],
    confirmationMethod: json["confirmation_method"]== null ? null : json["confirmation_method"],
    created: json["created"]== null ? null : json["created"],
    currency: json["currency"]== null ? null : json["currency"],
    customer: json["customer"]== null ? null : json["customer"],
    description: json["description"]== null ? null : json["description"],
    invoice: json["invoice"]== null ? null : json["invoice"],
    lastPaymentError: json["last_payment_error"]== null ? null : json["last_payment_error"],
    livemode: json["livemode"]== null ? null : json["livemode"],
    metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
    nextAction: json["next_action"]== null ? null : json["next_action"],
    onBehalfOf: json["on_behalf_of"]== null ? null : json["on_behalf_of"],
    paymentMethod: json["payment_method"]== null ? null : json["payment_method"],
    paymentMethodOptions: PaymentMethodOptions.fromJson(json["payment_method_options"]),
    paymentMethodTypes: List<String>.from(json["payment_method_types"].map((x) => x)),
    processing: json["processing"]== null ? null : json["processing"],
    receiptEmail: json["receipt_email"]== null ? null : json["receipt_email"],
    review: json["review"]== null ? null : json["review"],
    setupFutureUsage: json["setup_future_usage"]== null ? null : json["setup_future_usage"],
    shipping: json["shipping"]== null ? null : json["shipping"],
    source: json["source"]== null ? null : json["source"],
    statementDescriptor: json["statement_descriptor"]== null ? null : json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"]== null ? null : json["statement_descriptor_suffix"],
    status: json["status"]== null ? null : json["status"],
    transferData: json["transfer_data"]== null ? null : json["transfer_data"],
    transferGroup: json["transfer_group"]== null ? null : json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "amount_capturable": amountCapturable,
    "amount_received": amountReceived,
    "application": application,
    "application_fee_amount": applicationFeeAmount,
    "automatic_payment_methods": automaticPaymentMethods,
    "canceled_at": canceledAt,
    "cancellation_reason": cancellationReason,
    "capture_method": captureMethod,
    "charges": charges!.toJson(),
    "client_secret": clientSecret,
    "confirmation_method": confirmationMethod,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "invoice": invoice,
    "last_payment_error": lastPaymentError,
    "livemode": livemode,
    "metadata": List<dynamic>.from(metadata!.map((x) => x)),
    "next_action": nextAction,
    "on_behalf_of": onBehalfOf,
    "payment_method": paymentMethod,
    "payment_method_options": paymentMethodOptions!.toJson(),
    "payment_method_types": List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
    "processing": processing,
    "receipt_email": receiptEmail,
    "review": review,
    "setup_future_usage": setupFutureUsage,
    "shipping": shipping,
    "source": source,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "status": status,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class Datum {
  Datum({
    this.id,
    this.object,
    this.amount,
    this.amountCaptured,
    this.amountRefunded,
    this.application,
    this.applicationFee,
    this.applicationFeeAmount,
    this.balanceTransaction,
    this.billingDetails,
    this.calculatedStatementDescriptor,
    this.captured,
    this.created,
    this.currency,
    this.customer,
    this.description,
    this.destination,
    this.dispute,
    this.disputed,
    this.failureCode,
    this.failureMessage,
    this.fraudDetails,
    this.invoice,
    this.livemode,
    this.metadata,
    this.onBehalfOf,
    this.order,
    this.outcome,
    this.paid,
    this.paymentIntent,
    this.paymentMethod,
    this.paymentMethodDetails,
    this.receiptEmail,
    this.receiptNumber,
    this.receiptUrl,
    this.refunded,
    this.refunds,
    this.review,
    this.shipping,
    this.source,
    this.sourceTransfer,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    this.status,
    this.transferData,
    this.transferGroup,
  });

  String? id;
  String? object;
  int? amount;
  int? amountCaptured;
  int? amountRefunded;
  dynamic application;
  dynamic applicationFee;
  dynamic applicationFeeAmount;
  String? balanceTransaction;
  BillingDetails? billingDetails;
  String? calculatedStatementDescriptor;
  bool? captured;
  int? created;
  String? currency;
  String? customer;
  dynamic description;
  dynamic destination;
  dynamic dispute;
  bool? disputed;
  dynamic failureCode;
  dynamic failureMessage;
  List<dynamic>? fraudDetails;
  dynamic invoice;
  bool? livemode;
  List<dynamic>? metadata;
  dynamic onBehalfOf;
  dynamic order;
  Outcome? outcome;
  bool? paid;
  String? paymentIntent;
  String? paymentMethod;
  PaymentMethodDetails? paymentMethodDetails;
  dynamic receiptEmail;
  dynamic receiptNumber;
  String? receiptUrl;
  bool? refunded;
  Charges? refunds;
  dynamic review;
  dynamic shipping;
  dynamic source;
  dynamic sourceTransfer;
  dynamic statementDescriptor;
  dynamic statementDescriptorSuffix;
  String? status;
  dynamic transferData;
  String? transferGroup;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"]== null ? null : json["id"],
    object: json["object"]== null ? null : json["object"],
    amount: json["amount"]== null ? null : json["amount"],
    amountCaptured: json["amount_captured"]== null ? null : json["amount_captured"],
    amountRefunded: json["amount_refunded"]== null ? null : json["amount_refunded"],
    application: json["application"]== null ? null : json["application"],
    applicationFee: json["application_fee"]== null ? null : json["application_fee"],
    applicationFeeAmount: json["application_fee_amount"]== null ? null : json["application_fee_amount"],
    balanceTransaction: json["balance_transaction"]== null ? null : json["balance_transaction"],
    billingDetails: BillingDetails.fromJson(json["billing_details"]== null ? null : json["billing_details"],),
    calculatedStatementDescriptor: json["calculated_statement_descriptor"]== null ? null : json["calculated_statement_descriptor"],
    captured: json["captured"]== null ? null : json["captured"],
    created: json["created"]== null ? null : json["created"],
    currency: json["currency"]== null ? null : json["currency"],
    customer: json["customer"]== null ? null : json["customer"],
    description: json["description"]== null ? null : json["description"],
    destination: json["destination"]== null ? null : json["destination"],
    dispute: json["dispute"]== null ? null : json["dispute"],
    disputed: json["disputed"]== null ? null : json["disputed"],
    failureCode: json["failure_code"]== null ? null : json["failure_code"],
    failureMessage: json["failure_message"]== null ? null : json["failure_message"],
    fraudDetails: List<dynamic>.from(json["fraud_details"].map((x) => x)),
    invoice: json["invoice"]== null ? null : json["invoice"],
    livemode: json["livemode"]== null ? null : json["livemode"],
    metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
    onBehalfOf: json["on_behalf_of"]== null ? null : json["on_behalf_of"],
    order: json["order"]== null ? null : json["order"],
    outcome: Outcome.fromJson(json["outcome"]),
    paid: json["paid"]== null ? null : json["paid"],
    paymentIntent: json["payment_intent"]== null ? null : json["payment_intent"],
    paymentMethod: json["payment_method"]== null ? null : json["payment_method"],
    paymentMethodDetails: PaymentMethodDetails.fromJson(json["payment_method_details"]),
    receiptEmail: json["receipt_email"]== null ? null : json["receipt_email"],
    receiptNumber: json["receipt_number"]== null ? null : json["receipt_number"],
    receiptUrl: json["receipt_url"]== null ? null : json["receipt_url"],
    refunded: json["refunded"]== null ? null : json["refunded"],
    refunds: Charges.fromJson(json["refunds"]),
    review: json["review"]== null ? null : json["review"],
    shipping: json["shipping"]== null ? null : json["shipping"],
    source: json["source"]== null ? null : json["source"],
    sourceTransfer: json["source_transfer"]== null ? null : json["source_transfer"],
    statementDescriptor: json["statement_descriptor"]== null ? null : json["statement_descriptor"],
    statementDescriptorSuffix: json["statement_descriptor_suffix"]== null ? null : json["statement_descriptor_suffix"],
    status: json["status"]== null ? null : json["status"],
    transferData: json["transfer_data"]== null ? null : json["transfer_data"],
    transferGroup: json["transfer_group"]== null ? null : json["transfer_group"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "amount": amount,
    "amount_captured": amountCaptured,
    "amount_refunded": amountRefunded,
    "application": application,
    "application_fee": applicationFee,
    "application_fee_amount": applicationFeeAmount,
    "balance_transaction": balanceTransaction,
    "billing_details": billingDetails!.toJson(),
    "calculated_statement_descriptor": calculatedStatementDescriptor,
    "captured": captured,
    "created": created,
    "currency": currency,
    "customer": customer,
    "description": description,
    "destination": destination,
    "dispute": dispute,
    "disputed": disputed,
    "failure_code": failureCode,
    "failure_message": failureMessage,
    "fraud_details": List<dynamic>.from(fraudDetails!.map((x) => x)),
    "invoice": invoice,
    "livemode": livemode,
    "metadata": List<dynamic>.from(metadata!.map((x) => x)),
    "on_behalf_of": onBehalfOf,
    "order": order,
    "outcome": outcome!.toJson(),
    "paid": paid,
    "payment_intent": paymentIntent,
    "payment_method": paymentMethod,
    "payment_method_details": paymentMethodDetails!.toJson(),
    "receipt_email": receiptEmail,
    "receipt_number": receiptNumber,
    "receipt_url": receiptUrl,
    "refunded": refunded,
    "refunds": refunds!.toJson(),
    "review": review,
    "shipping": shipping,
    "source": source,
    "source_transfer": sourceTransfer,
    "statement_descriptor": statementDescriptor,
    "statement_descriptor_suffix": statementDescriptorSuffix,
    "status": status,
    "transfer_data": transferData,
    "transfer_group": transferGroup,
  };
}

class Charges {
  Charges({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  String? object;
  List<Datum>? data;
  bool? hasMore;
  int? totalCount;
  String? url;

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    object: json["object"]== null ? null : json["object"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    hasMore: json["has_more"]== null ? null : json["has_more"],
    totalCount: json["total_count"]== null ? null : json["total_count"],
    url: json["url"]== null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "has_more": hasMore,
    "total_count": totalCount,
    "url": url,
  };
}

class BillingDetails {
  BillingDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
  });

  Address? address;
  dynamic email;
  dynamic name;
  dynamic phone;

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
    address: Address.fromJson(json["address"]),
    email: json["email"]== null ? null : json["email"],
    name: json["name"]== null ? null : json["name"],
    phone: json["phone"]== null ? null : json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address": address!.toJson(),
    "email": email,
    "name": name,
    "phone": phone,
  };
}

class Address {
  Address({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"]== null ? null : json["city"],
    country: json["country"]== null ? null : json["country"],
    line1: json["line1"]== null ? null : json["line1"],
    line2: json["line2"]== null ? null : json["line2"],
    postalCode: json["postal_code"]== null ? null : json["postal_code"],
    state: json["state"]== null ? null : json["state"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "line1": line1,
    "line2": line2,
    "postal_code": postalCode,
    "state": state,
  };
}

class Outcome {
  Outcome({
    this.networkStatus,
    this.reason,
    this.riskLevel,
    this.riskScore,
    this.sellerMessage,
    this.type,
  });

  String? networkStatus;
  dynamic reason;
  String? riskLevel;
  int? riskScore;
  String? sellerMessage;
  String? type;

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
    networkStatus: json["network_status"]== null ? null : json["network_status"],
    reason: json["reason"]== null ? null : json["reason"],
    riskLevel: json["risk_level"]== null ? null : json["risk_level"],
    riskScore: json["risk_score"]== null ? null : json["risk_score"],
    sellerMessage: json["seller_message"]== null ? null : json["seller_message"],
    type: json["type"]== null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "network_status": networkStatus,
    "reason": reason,
    "risk_level": riskLevel,
    "risk_score": riskScore,
    "seller_message": sellerMessage,
    "type": type,
  };
}

class PaymentMethodDetails {
  PaymentMethodDetails({
    this.card,
    this.type,
  });

  PaymentMethodDetailsCard? card;
  String? type;

  factory PaymentMethodDetails.fromJson(Map<String, dynamic> json) => PaymentMethodDetails(
    card: PaymentMethodDetailsCard.fromJson(json["card"]),
    type: json["type"]== null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "card": card!.toJson(),
    "type": type,
  };
}

class PaymentMethodDetailsCard {
  PaymentMethodDetailsCard({
    this.brand,
    this.checks,
    this.country,
    this.expMonth,
    this.expYear,
    this.fingerprint,
    this.funding,
    this.installments,
    this.last4,
    this.network,
    this.threeDSecure,
    this.wallet,
  });

  String? brand;
  Checks? checks;
  String? country;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  dynamic installments;
  String? last4;
  String? network;
  dynamic threeDSecure;
  dynamic wallet;

  factory PaymentMethodDetailsCard.fromJson(Map<String, dynamic> json) => PaymentMethodDetailsCard(
    brand: json["brand"]== null ? null : json["brand"],
    checks: Checks.fromJson(json["checks"]),
    country: json["country"]== null ? null : json["country"],
    expMonth: json["exp_month"]== null ? null : json["exp_month"],
    expYear: json["exp_year"]== null ? null : json["exp_year"],
    fingerprint: json["fingerprint"]== null ? null : json["fingerprint"],
    funding: json["funding"]== null ? null : json["funding"],
    installments: json["installments"]== null ? null : json["installments"],
    last4: json["last4"]== null ? null : json["last4"],
    network: json["network"]== null ? null : json["network"],
    threeDSecure: json["three_d_secure"]== null ? null : json["three_d_secure"],
    wallet: json["wallet"]== null ? null : json["wallet"],
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "checks": checks!.toJson(),
    "country": country,
    "exp_month": expMonth,
    "exp_year": expYear,
    "fingerprint": fingerprint,
    "funding": funding,
    "installments": installments,
    "last4": last4,
    "network": network,
    "three_d_secure": threeDSecure,
    "wallet": wallet,
  };
}

class Checks {
  Checks({
    this.addressLine1Check,
    this.addressPostalCodeCheck,
    this.cvcCheck,
  });

  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  dynamic cvcCheck;

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
    addressLine1Check: json["address_line1_check"],
    addressPostalCodeCheck: json["address_postal_code_check"],
    cvcCheck: json["cvc_check"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1_check": addressLine1Check,
    "address_postal_code_check": addressPostalCodeCheck,
    "cvc_check": cvcCheck,
  };
}

class PaymentMethodOptions {
  PaymentMethodOptions({
    this.card,
  });

  PaymentMethodOptionsCard? card;

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => PaymentMethodOptions(
    card: PaymentMethodOptionsCard.fromJson(json["card"]),
  );

  Map<String, dynamic> toJson() => {
    "card": card!.toJson(),
  };
}

class PaymentMethodOptionsCard {
  PaymentMethodOptionsCard({
    this.installments,
    this.network,
    this.requestThreeDSecure,
  });

  dynamic installments;
  dynamic network;
  String? requestThreeDSecure;

  factory PaymentMethodOptionsCard.fromJson(Map<String, dynamic> json) => PaymentMethodOptionsCard(
    installments: json["installments"],
    network: json["network"],
    requestThreeDSecure: json["request_three_d_secure"],
  );

  Map<String, dynamic> toJson() => {
    "installments": installments,
    "network": network,
    "request_three_d_secure": requestThreeDSecure,
  };
}

class UserInfo {
  UserInfo({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.deviceId,
    this.phone,
    this.profilePic,
    this.bannerImage,
    this.customerId,
    this.isEmailVerified,
    this.notificationStatus,
    this.isEnable,
    this.lat,
    this.lng,
    this.isRegistrationComplete,
    this.subscriptionPlan,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.plan,
    this.rating,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic deviceId;
  dynamic phone;
  String? profilePic;
  dynamic bannerImage;
  String? customerId;
  dynamic isEmailVerified;
  int? notificationStatus;
  int? isEnable;
  dynamic lat;
  dynamic lng;
  int? isRegistrationComplete;
  int? subscriptionPlan;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? plan;
  int? rating;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    deviceId: json["device_id"],
    phone: json["phone"],
    profilePic: json["profile_pic"],
    bannerImage: json["banner_image"],
    customerId: json["customer_id"],
    isEmailVerified: json["isEmailVerified"],
    notificationStatus: json["notification_status"],
    isEnable: json["is_enable"],
    lat: json["lat"],
    lng: json["lng"],
    isRegistrationComplete: json["isRegistrationComplete"],
    subscriptionPlan: json["subscription_plan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    plan: json["plan"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "device_id": deviceId,
    "phone": phone,
    "profile_pic": profilePic,
    "banner_image": bannerImage,
    "customer_id": customerId,
    "isEmailVerified": isEmailVerified,
    "notification_status": notificationStatus,
    "is_enable": isEnable,
    "lat": lat,
    "lng": lng,
    "isRegistrationComplete": isRegistrationComplete,
    "subscription_plan": subscriptionPlan,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "plan": plan,
    "rating": rating,
  };
}
