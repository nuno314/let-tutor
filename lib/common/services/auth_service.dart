import 'package:let_tutor/data/models/response.dart';

abstract class AuthService {
  Future<void> init();

  bool get isSignedIn;

  String? get token;

  Future<LoginResponse?> loginWithEmail(
      {required String email, required String password});

  Future<LoginResponse?> loginWithFacebook({
    required String token,
  });

  Future<LoginResponse?> loginWithPhoneNumber({
    required String phoneNumber,
    required String password,
  });

  Future<LoginResponse?> loginWithGoogle({
    required String token,
  });

  Future<void> signOut();

  Future<String?> refreshToken();
}
