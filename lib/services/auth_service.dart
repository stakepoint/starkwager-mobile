import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class LoginResponse {
  final String token;
  
  LoginResponse({required this.token});
  
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json['token']);
  }
}

class AuthService {
  Future<LoginResponse> createLogin(String walletAddress) async {
    final url = '${ApiConstants.baseUrl}${ApiConstants.createLogin}';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'walletAddress': walletAddress,
      }),
    );
    
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}