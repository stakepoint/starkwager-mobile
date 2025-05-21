import 'package:flutter/material.dart';
import '../models/wager_create_request.dart';
import '../models/wager_create_response.dart';
import '../services/wager_service.dart';

class WagerProvider extends ChangeNotifier {
  final WagerService _wagerService = WagerService();
  bool isLoading = false;
  String? error;
  WagerCreateResponse? createdWager;

  Future<bool> createWager({
    required String title,
    required String description,
    required DateTime deadline,
    required double amount,
    required String outcomeA,
    required String outcomeB,
    required String token,
  }) async {
    isLoading = true;
    error = null;
    notifyListeners();
    
    try {
      final request = WagerCreateRequest(
        title: title,
        description: description,
        deadline: deadline,
        amount: amount,
        outcomeA: outcomeA,
        outcomeB: outcomeB,
      );
      
      createdWager = await _wagerService.createWager(request, token);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}