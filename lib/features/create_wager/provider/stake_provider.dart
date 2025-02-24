import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Provider to track if the amount is in Stark or USD
// final isStarkProvider = StateProvider<bool>((ref) => true);

// // Provider to store the current stake amount
// final stakeAmountProvider = StateProvider<String>((ref) => '');

final isStarkProvider = StateProvider<bool>((ref) => true);
final stakeAmountProvider = StateProvider<double>((ref) => 0.0);