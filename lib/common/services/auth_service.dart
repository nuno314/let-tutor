import 'package:let_tutor/data/models/login_response.dart';

abstract class AuthService {
  Future<void> init();

  bool get isSignedIn;

  String? get token;

  Future<LoginResponse?> loginWithEmail(
      {required String email, required String password});

  Future<void> signOut();

  Future<String?> refreshToken();
}
