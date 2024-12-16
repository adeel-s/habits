import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:habits/firebase_options.dart';
import 'package:habits/services/auth/auth_exceptions.dart';
import 'package:habits/services/auth/auth_provider.dart' as auth_provider;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habits/services/auth/auth_user.dart';

class FirebaseAuthProvider implements auth_provider.AuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      }
      log('User creation failed');
      throw UserNotLoggedInException();
      //throw UserNotLoggedInException;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log(e.code);
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        log('email already in use');
        throw EmailAlreadyInUseException();
      } else if (e.code == 'invalid-email') {
        log('Invalid email');
        throw InvalidEmailFormatException();
      } else {
        log(e.toString());
        throw GenericAuthException();
      }
    } catch (e) {
      log('Something bad happened');
      log(e.runtimeType.toString());
      log(e.toString());
      throw GenericAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
