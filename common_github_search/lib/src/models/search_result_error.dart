class SearchResultError implements Exception {
  final String message;

  const SearchResultError({required this.message});

  factory SearchResultError.fromJson(Map<String, dynamic> json) =>
      SearchResultError(message: json['message'] as String);
}
