class ServerException implements Exception {
  final String message;
  ServerException({this.message = "Server Error"});
}

class ConnectionException implements Exception {}

class LocalStorageException implements Exception {}

class RegistrationException implements Exception {
  final String? message;
  RegistrationException(this.message);
}

class UserNotFoundException implements Exception {
  final String? message;
  UserNotFoundException([this.message = "User Not Found"]);
}

class LoginException implements Exception {
  final String? message;
  LoginException(this.message);
}

class ProductNotFoundException implements Exception {
  final String message;
  ProductNotFoundException([this.message = 'product not found']);
}

class RefreshTokenException implements Exception {}

class BadOTPException implements Exception {
  final String? message;
  BadOTPException(this.message);
}

class NotAuthorizedException implements Exception {}

class DataNotFoundException implements Exception {
  final String? message;
  DataNotFoundException(this.message);
}

// cart_exceptions.dart

class CartNotFoundException implements Exception {
  final String message;
  CartNotFoundException([this.message = 'Cart not found']);
}

class SaleNotFoundException implements Exception {
  final String message;
  SaleNotFoundException([this.message = 'Sale not found']);
}

class InvalidSaleIdException implements Exception {
  final String message;
  InvalidSaleIdException([this.message = 'Invalid saleId']);
}

//category exeption
class CategoryNotFoundException implements Exception {
  final String message;
  CategoryNotFoundException({this.message = "Category Not Found"});
}

//order exeption
class BadRequestException implements Exception {
  final String? message;

  BadRequestException({this.message = 'Invalid request data.'});
}

class NotFoundException implements Exception {
  final String? message;

  NotFoundException({this.message = 'The requested data was not found.'});
}

class UnknownException implements Exception {
  final String? message;

  UnknownException({this.message = 'An unknown error occurred.'});
}
