//PAYMENTS SERVICE

abstract class PaymentGatewayService {
  Future<String?> pay(double amount);
}

class StripePayment implements PaymentGatewayService {
  @override
  Future<String?> pay(double amount) async {
    // Call Stripe API
    if (amount > 0) {
      return "Pay $amount with Stripe Payment";
    } else {
      return "Payment is not valid";
    }
  }
}

class PayPalPayment implements PaymentGatewayService {
  @override
  Future<String?> pay(double amount) async {
    if (amount > 0) {
      return "Pay $amount with Paypal Payment";
    } else {
      return "Payment is not valid";
    }
  }
}
