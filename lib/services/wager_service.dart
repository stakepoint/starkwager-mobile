import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wager_create_request.dart';
import '../models/wager_create_response.dart';
import '../utils/constants.dart';

class WagerService {
  final String baseUrl = ApiConstants.baseUrl;
  
  Future<WagerCreateResponse> createWager(WagerCreateRequest request, String token) async {
    final url = '$baseUrl/wagers/create';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return WagerCreateResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create wager: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}