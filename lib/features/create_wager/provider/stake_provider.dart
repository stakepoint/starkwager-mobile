import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isStarkProvider = StateProvider<bool>((ref) => true);
final stakeAmountProvider = StateProvider<double>((ref) => 0.0);

final textControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
