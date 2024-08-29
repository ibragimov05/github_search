import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/models.dart';

class GithubClient {
  final String baseUrl;
  final http.Client httpClient;

  GithubClient({
    http.Client? httpClient,
    this.baseUrl = 'https://api.github.com/search/repositories?q=',
  }) : httpClient = httpClient ?? http.Client();

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$term"));

    final results = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }
}
