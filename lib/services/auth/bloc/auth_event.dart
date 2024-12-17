abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister({
    required this.email,
    required this.password,
  });
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthEventSignIn({
    required this.email,
    required this.password,
  });
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}
