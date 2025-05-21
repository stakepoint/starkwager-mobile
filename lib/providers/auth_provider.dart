import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isConnected = false;
  
  String? get token => _token;
  bool get isConnected => _isConnected;
  
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    _isConnected = _token != null;
    notifyListeners();
  }
  
  Future<bool> connectWallet(String walletAddress) async {
    try {
      final authService = AuthService();
      final loginResponse = await authService.createLogin(walletAddress);
      
      _token = loginResponse.token;
      _isConnected = true;
      
      // Save token to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', _token!);
      
      notifyListeners();
      return true;
    } catch (e) {
      print('Error connecting wallet: $e');
      return false;
    }
  }
  
  void disconnect() async {
    _token = null;
    _isConnected = false;
    
    // Clear token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    
    notifyListeners();
  }
}