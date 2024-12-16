import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:habits/firebase_options.dart';
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
  Future<AuthUser> createUser ({required String email, required String password,}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword (email: email, password: password,);
      final user = currentUser;
      if (user != null) {
        return user;
      }
      log('User creation failed');
      throw Exception();
      //throw UserNotLoggedInException;
    } on FirebaseAuthException catch (e) {
      log('Exception thrown while creating user');
      throw Exception();
    }
  }
  
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp (
      options: DefaultFirebaseOptions.currentPlatform, );
    
  }
}
