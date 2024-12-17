//Authentical exceptions
class UserNotFoundAuthException implements Exception {}

class InvalidCredentialException implements Exception {}

class InvalidEmailFormatException implements Exception {}

class WeakPasswordException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class UserNotSignedInException implements Exception {}

//generic exceptions

class GenericAuthException implements Exception {}
