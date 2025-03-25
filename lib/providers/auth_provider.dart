import 'package:flutter/material.dart';
import 'package:payment_gateways_app/models/user_model.dart';
import 'package:payment_gateways_app/services/auth/auth_service.dart';
import 'package:payment_gateways_app/services/auth/facebook_service.dart';
import 'package:payment_gateways_app/services/auth/firebase_auth_service.dart';
import 'package:payment_gateways_app/services/auth/google_service.dart';

enum AuthenticateType { email, google, facebook,firebase }

class AuthProvider with ChangeNotifier {
  AuthService? _authService;
  UserModel? user;

  bool? isRegistered;
    bool? isLogin;


  void selectAuth(AuthenticateType service) {
    if (service == AuthenticateType.email) {
      _authService = EmailAuthService();
    } else if (service == AuthenticateType.facebook) {
      _authService = FacebookAuthService();
    } else if (service == AuthenticateType.google) {
      _authService = GoogleAuthService();
    }else if (service == AuthenticateType.firebase){
      _authService = FirebaseAuthService();
    }

    notifyListeners();
  }

  Future<void> signIn({String? email, String? password}) async {
  isLogin = await _authService?.signIn(email: email, password: password);
  notifyListeners();
  }

  Future<void> signOut() async {
    await _authService?.signOut();
  }

  Future<void> register({required String email,required String password }) async {
   isRegistered = await _authService?.register(email: email, password: password);
    notifyListeners();
  }

  Future<UserModel?> getCurrentUser() async {
   var user = await _authService?.getCurrentUser();
    notifyListeners();
    return user;
  }
}
