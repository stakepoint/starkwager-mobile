import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/hashtag.dart';
import '../../../domain/usecases/get_all_hashtags.dart';

class HashtagsNotifier extends StateNotifier<Set<String>> {
  HashtagsNotifier() : super({});

  void toggleHashtag(String hashtag) {
    if (state.contains(hashtag)) {
      state = Set.from(state)..remove(hashtag);
    } else {
      state = Set.from(state)..add(hashtag);
    }
  }

  void clearHashtags() {
    state = {};
  }
}

class WagerTitleNotifier extends StateNotifier<String> {
  WagerTitleNotifier() : super('');

  void setTitle(String title) {
    state = title;
  }
}

// API Hashtag States
abstract class HashtagApiState {}

class HashtagApiInitial extends HashtagApiState {}

class HashtagApiLoading extends HashtagApiState {}

class HashtagApiLoaded extends HashtagApiState {
  final HashtagsResponse hashtags;
  HashtagApiLoaded(this.hashtags);
}

class HashtagApiError extends HashtagApiState {
  final String message;
  HashtagApiError(this.message);
}

// Hashtag API Notifier
class HashtagApiNotifier extends StateNotifier<HashtagApiState> {
  final GetAllHashtags getAllHashtags;

  HashtagApiNotifier(this.getAllHashtags) : super(HashtagApiInitial()) {
    fetchHashtags();
  }

  Future<void> fetchHashtags() async {
    try {
      state = HashtagApiLoading();
      final hashtags = await getAllHashtags();
      state = HashtagApiLoaded(hashtags);
    } catch (e) {
      state = HashtagApiError(e.toString());
    }
  }
}
