class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );
}
