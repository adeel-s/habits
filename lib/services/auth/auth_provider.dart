import 'package:habits/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser?
      get currentUser; //This is a getter in dart that grabs an instance variable called currentUser?
  Future<void> initialize();

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> sendEmailVerification();

  //forgot password
}
