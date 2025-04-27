import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../data/datasources/hashtag_remote_datasource.dart';
import '../../../data/repositories/hashtag_repository_impl.dart';
import '../../../domain/usecases/get_all_hashtags.dart';
import '../state/hashtag_state.dart';

final selectedHashtagsProvider =
    StateNotifierProvider<HashtagsNotifier, Set<String>>((ref) {
  return HashtagsNotifier();
});

final wagerTitleProvider =
    StateNotifierProvider<WagerTitleNotifier, String>((ref) {
  return WagerTitleNotifier();
});

// Provider to supply the GetAllHashtags use case
final getAllHashtagsUseCaseProvider = Provider((ref) {
  final apiClient = ref.read(apiClientProvider);
  final remoteDatasource = HashtagRemoteDatasourceImpl(apiClient, ref);
  final repository = HashtagRepositoryImpl(remoteDatasource);
  return GetAllHashtags(repository);
});

// State notifier to handle hashtag loading state
final hashtagsApiNotifierProvider =
    StateNotifierProvider<HashtagApiNotifier, HashtagApiState>((ref) {
  final getAllHashtags = ref.read(getAllHashtagsUseCaseProvider);
  return HashtagApiNotifier(getAllHashtags);
});

// Provider to expose just the list of hashtag names for UI consumption
final hashtagsListProvider = Provider<List<String>>((ref) {
  final state = ref.watch(hashtagsApiNotifierProvider);
  
  if (state is HashtagApiLoaded) {
    return state.hashtags.hashtags
        .map((hashtag) => hashtag.name)
        .toList();
  } else {
    // Fallback if hashtags haven't loaded yet
    return [
      'Bitcoin',
      'STRKBet',
      'BTCto100k',
      'CryptoBetting',
      'BlockchainWager',
      'CryptoTrends',
      'Web3Challenge',
      'DeFiPrediction'
    ];
  }
});
