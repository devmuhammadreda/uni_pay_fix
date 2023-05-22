import 'package:uni_pay/uni_pay.dart';

import '../../constant/uni_text.dart';
import '../keys/api_keys.dart';

class UniPayCredentials {
  ///* Payment methods to be shown in gateway `[UniPayPaymentMethods.card]`
  late List<UniPayPaymentMethods> paymentMethods;

  ///* Moyasar credentials
  late MoyasarCredential? moyasarCredential;

  ///* Tamara credentials
  late TamaraCredential? tamaraCredential;

  ///* Apple pay merchant identifier
  late String? applePayMerchantIdentifier;

  UniPayCredentials({
    required this.paymentMethods,
    this.moyasarCredential,
    this.tamaraCredential,
    this.applePayMerchantIdentifier,
  })  : assert(
            paymentMethods.isMoyasarGateway ? moyasarCredential != null : true,
            UniPayText.pleaseProvideMoyasarCredentails),
        assert(paymentMethods.isTamaraGateway ? tamaraCredential != null : true,
            UniPayText.pleaseProvideTamaraCredentails),
        assert(paymentMethods.isNotEmpty, UniPayText.noGatewayProvided),
        assert(moyasarCredential != null || tamaraCredential != null,
            UniPayText.pleaseProvideCredentials),
        assert(
            paymentMethods.isApplePay
                ? applePayMerchantIdentifier != null
                : true,
            UniPayText.applePayMerchantIdentifierError);

  UniPayCredentials.fromJson(Map<String, dynamic> json) {
    paymentMethods =
        json['paymentMethods'].map((e) => UniPayPaymentMethods.values[e]);
    moyasarCredential = MoyasarCredential.fromJson(json['moyasarCredential']);
    tamaraCredential = TamaraCredential.fromJson(json['tamaraCredential']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethods'] = paymentMethods.map((e) => e..index).toList();
    data['moyasarCredential'] = moyasarCredential?.toJson();
    data['tamaraCredential'] = tamaraCredential?.toJson();
    return data;
  }
}

///* Moyasar credential
class MoyasarCredential {
  ///* Moyasar publishable key
  late String publishableKey;

  ///* Moyasar secret key
  late String secretKey;

  MoyasarCredential({
    required this.publishableKey,
    required this.secretKey,
  });

  MoyasarCredential.fromJson(Map<String, dynamic> json) {
    publishableKey = json['publishableKey'];
    secretKey = json['secretKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['publishableKey'] = publishableKey;
    data['secretKey'] = secretKey;
    return data;
  }
}

///* Tamara credential
class TamaraCredential {
  ///* Tamara token
  late String token;

  ///* Merchant `Urls` for Tamara
  late MerchantUrl merchantUrl;

  TamaraCredential({required this.token, required this.merchantUrl});

  TamaraCredential.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    merchantUrl = MerchantUrl.fromJson(json['merchantUrl']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['merchantUrl'] = merchantUrl.toJson();
    return data;
  }
}

class MerchantUrl {
  late String success;
  late String failure;
  late String cancel;
  late String notification;

  MerchantUrl({
    this.success = ApiKeys.successUrl,
    this.failure = ApiKeys.failedUrl,
    this.cancel = ApiKeys.cancelUrl,
    required this.notification,
  });

  MerchantUrl.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    failure = json['failure'];
    cancel = json['cancel'];
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['failure'] = failure;
    data['cancel'] = cancel;
    data['notification'] = notification;
    return data;
  }
}
