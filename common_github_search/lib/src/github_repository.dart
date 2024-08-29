import 'package:common_github_search/common_github_search.dart';

class GithubRepository {
  final GithubCache cache;
  final GithubClient client;

  const GithubRepository({
    required this.cache,
    required this.client,
  });

  Future<SearchResult> search(String term) async {
    final cachedResult = cache.get(term);

    if (cachedResult != null) return cachedResult;

    final result = await client.search(term);

    cache.set(term: term, result: result);

    return result;
  }
}
