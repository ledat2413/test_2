import 'package:flutter/material.dart';
import 'package:payment_gateways_app/services/payment/payments.dart';

enum PaymentGateway { paypal, stripe }

class PaymentProvider with ChangeNotifier {
  PaymentGatewayService? _paymentService;

  void selectGateway(PaymentGateway gateway) {
    if (gateway == PaymentGateway.paypal) {
      _paymentService = PayPalPayment();
    } else if (gateway == PaymentGateway.stripe) {
      _paymentService = StripePayment();
    }
    notifyListeners();
  }

  Future<String?> pay(double amount) async {
    if (_paymentService == null) return "No Payment Gateway Selected";
    return await _paymentService!.pay(amount);
  }
}
