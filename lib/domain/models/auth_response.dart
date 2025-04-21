import 'user.dart';
import 'tokens.dart';

class AuthResponse {
  final String message;
  final User user;
  final Tokens tokens;

  AuthResponse({required this.message, required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json['message'],
        user: User.fromJson(json['user']),
        tokens: Tokens.fromJson(json['tokens']),
      );
}
