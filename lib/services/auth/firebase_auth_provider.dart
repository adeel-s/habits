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
      throw UserNotSignedInException();
      //throw UserNotLoggedInException;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log(e.code);
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        log('email already in use');
        //TODO: Add invalid credential cases
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
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotSignedInException;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log(e.code);
        throw UserNotFoundAuthException();
      } else if (e.code == 'invalid-email') {
        log('Invalid email format');
        throw InvalidEmailFormatException();
      } else if (e.code == 'invalid-credential') {
        log('Invalid credentials');
        throw InvalidCredentialException();
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

  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotSignedInException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotSignedInException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
