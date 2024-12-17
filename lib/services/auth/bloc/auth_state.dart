import 'package:habits/services/auth/auth_user.dart';

abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState(
      {required this.isLoading, this.loadingText = 'Please wait a moment'});
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required super.isLoading,
  });
}

class AuthStateSignedOut extends AuthState {
  final Exception? exception;
  const AuthStateSignedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
}

class AuthStatePlaceholder extends AuthState {
  final Exception? exception;
  const AuthStatePlaceholder({
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({
    required super.isLoading,
  });
}

class AuthStateSignedIn extends AuthState {
  final AuthUser user;
  const AuthStateSignedIn({
    required this.user,
    required super.isLoading,
  });
}
