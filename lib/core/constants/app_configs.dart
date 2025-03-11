import 'dart:io';

class AppConfigs {
  static String baseUrl = 'https://dummyjson.com';
}
final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');
