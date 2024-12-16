import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable 
class AuthUser {
  final String id;
  final String email;
  final bool isVerified;

  AuthUser({required this.id, required this.email, required this.isVerified,});
  
  factory AuthUser.fromFirebase(User user) => AuthUser(id: user.uid, email: user.email!, isVerified: user.emailVerified,);
}

