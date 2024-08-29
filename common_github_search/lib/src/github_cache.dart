import 'models/search_result.dart';

class GithubCache {
  final _cache = <String, SearchResult>{};

  SearchResult? get(String term) => _cache[term];

  void set({
    required String term,
    required SearchResult result,
  }) =>
      _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}
