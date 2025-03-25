import 'package:flutter/material.dart';
import 'package:payment_gateways_app/features/home/home_screen.dart';
import 'package:payment_gateways_app/providers/auth_provider.dart';
import 'package:payment_gateways_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  () => _login(context, AuthenticateType.email),
              child: Text('Login'),
            ),
            SizedBox(height: 20),
             Row(
               children: [
                 Expanded(
                   child: ElevatedButton(
                    onPressed:
                        () => _login(context, AuthenticateType.firebase),
                    child: Text('Login with Firebase'),
                               ),
                 ),
                  SizedBox(width: 20),
                   Expanded(
                     child: ElevatedButton(
                                       onPressed:
                        () => _register(context,AuthenticateType.firebase),
                                       child: Text('Register with Firebase'),
                               ),
                   ),           
               ],
             ),
                        SizedBox(height: 20),

            ElevatedButton(
              onPressed:
                  () => _login(context, AuthenticateType.google),
              child: Text('Login with Google'),
            ),
            ElevatedButton(
              onPressed:
                  () =>
                      _login(context, AuthenticateType.facebook),
              child: Text('Login with Facebook'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }


  void _register(
    BuildContext loginContext,
    AuthenticateType service,
  ) async {
    if (service == AuthenticateType.firebase) {
      final authProvider =  Provider.of<AuthProvider>(context, listen: false);
      authProvider.selectAuth(service);
      await authProvider.register(email: _emailController.text, password: _passwordController.text);
      var result = authProvider.isRegistered;
      if (result == true ){
        ScaffoldMessenger.of(loginContext).showSnackBar(SnackBar(content: Text('Register Success!')));
         Navigator.pushAndRemoveUntil(
          loginContext,
          MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false,);
      }else {
          ScaffoldMessenger.of(loginContext).showSnackBar(SnackBar(content: Text('Register Failed!')));
      }
    }
  }  

  void _login(
    BuildContext loginContext,
    AuthenticateType service,
  ) async {
      final authProvider =  Provider.of<AuthProvider>(context, listen: false);

    if (service == AuthenticateType.email) {

      authProvider.selectAuth(AuthenticateType.email);
      await authProvider.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
       var result = authProvider.isLogin;
      if (result != false) {
       Navigator.pushAndRemoveUntil(
          loginContext,
          MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false,
        );
      }else {
          ScaffoldMessenger.of(loginContext).showSnackBar(SnackBar(content: Text('Login Failed!')));
      }
    } else if (service == AuthenticateType.facebook) {
      authProvider.selectAuth(AuthenticateType.facebook);
      authProvider.signIn();
    } else if (service == AuthenticateType.google) {
      authProvider.selectAuth(AuthenticateType.google);
      authProvider.signIn();
    }else if (service == AuthenticateType.firebase){
        authProvider.selectAuth(AuthenticateType.firebase);
        await authProvider.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var result = authProvider.isLogin;
      if (result == false) {
        ScaffoldMessenger.of(loginContext).showSnackBar(SnackBar(content: Text('Login with Firebase has Failed!')));
      }else {
        Navigator.pushAndRemoveUntil(
          loginContext,
          MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false,
        );
      }
    }
  }
}

