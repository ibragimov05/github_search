import 'package:common_github_search/src/models/search_result_item.dart';

class SearchResult {
  final List<SearchResultItem> items;

  const SearchResult({required this.items});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      items: (json['items'] as List<dynamic>)
          .map(
            (item) => SearchResultItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
