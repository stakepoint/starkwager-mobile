import 'dart:io';

class AppConfigs {
  static String baseUrl = 'https://starkwager-backend.onrender.com';
}

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
