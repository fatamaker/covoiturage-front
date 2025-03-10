class Failure {
  String? message;
  int? statusCode;

  Failure({this.message, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class ConnectionFailure extends Failure {}

class DataNotFoundFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String? message;
  DataNotFoundFailure(this.message);
}

class BadOTPFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String? message;

  BadOTPFailure(this.message);
}

class RegistrationFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String? message;

  RegistrationFailure(this.message);
}

class LoginFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String? message;

  LoginFailure(this.message);
}

class ProductNotFoundFailure extends Failure {
  ProductNotFoundFailure({super.message});
}

class LocalStorageFailure extends Failure {}

class NotAuthorizedFailure extends Failure {}

class UnknownFailure extends Failure {
  UnknownFailure({super.message, super.statusCode});

  @override
  String toString() => message ?? 'An unknown error occurred.';
}

class BadRequestFailure extends Failure {
  BadRequestFailure({super.message});
}
