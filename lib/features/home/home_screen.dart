import 'package:flutter/material.dart';
import 'package:payment_gateways_app/features/login/login_screen.dart';
import 'package:payment_gateways_app/providers/auth_provider.dart';
import 'package:payment_gateways_app/services/auth/auth_service.dart';
import 'package:payment_gateways_app/services/payment/payments.dart';
import 'package:provider/provider.dart';

import '../../providers/payment_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PaymentProvider _paymentProvider;

  @override
  Widget build(BuildContext context) {
     _paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Payment Gateway', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => _processPayment(
                    context,
                    PaymentGateway.paypal,
                    _paymentProvider,
                  ),
              child: Text('Pay with PayPal'),
            ),
            ElevatedButton(
              onPressed:
                  () => _processPayment(
                    context,
                    PaymentGateway.stripe,
                    _paymentProvider,
                  ),
              child: Text('Pay with Stripe'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed:
                  () async {
                     await Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).signOut();
                       Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                    
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment(
    BuildContext context,
    PaymentGateway service,
    PaymentProvider provider,
  ) async {
    if (service == PaymentGateway.stripe) {
      provider.selectGateway(PaymentGateway.stripe);

      var result = await provider.pay(100.0);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result ?? "Payment Failed")));
    } else if (service == PaymentGateway.paypal) {
      provider.selectGateway(PaymentGateway.paypal);

      var result = await provider.pay(280.0);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result ?? "Payment Failed")));
    }
  }
}
