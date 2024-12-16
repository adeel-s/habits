abstract class AuthEvent {
 const AuthEvent();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister({required this.email, required this.password,});
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}