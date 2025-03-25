import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateways_app/features/home/home_screen.dart';
import 'package:payment_gateways_app/features/login/login_screen.dart';
import 'package:payment_gateways_app/models/user_model.dart';
import 'package:payment_gateways_app/providers/auth_provider.dart';
import 'package:payment_gateways_app/providers/payment_provider.dart';
import 'package:payment_gateways_app/services/notification/push_notification.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    PushNotificationService().initialise();
  }

  @override
  Widget build(BuildContext context) {
    final getCurrentUser = context.read<AuthProvider>().getCurrentUser();
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<UserModel?>(
        future: getCurrentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
