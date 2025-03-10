class Token {
  final String token;

  final String userId;
  final DateTime expiryDate;

  const Token(
      {required this.token, required this.expiryDate, required this.userId});
}
