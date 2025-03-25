import 'package:payment_gateways_app/models/user_model.dart';
import 'package:payment_gateways_app/services/auth/auth_service.dart';

class GoogleAuthService implements AuthService {
  @override
  Future<bool> signIn({String? email, String? password}) async {
    print('Login with Google');
    // Google Sign-In logic
    return false;
  }

  @override
  Future<void> signOut() async {
    // Sign out from Google
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;

    // Get Google user
  }

  @override
  Future<bool> register({required String? email,required String? password }) async {
        //To Do register

    return false;
  
  }
}