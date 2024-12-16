

abstract class AuthState {
  final bool isLoading;
  String? loadingText;
  AuthState({required this.isLoading, this.loadingText = 'Please wait a moment'});
}

class AuthStateUninitialized extends AuthState {
  AuthStateUninitialized({required super.isLoading});
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  AuthStateRegistering({required this.exception, required super.isLoading,});
}