import 'package:flutter_riverpod/flutter_riverpod.dart';

final isStarkProvider = StateProvider<bool>((ref) => true);
final stakeAmountProvider = StateProvider<double>((ref) => 0.0);
