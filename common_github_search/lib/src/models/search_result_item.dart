import 'package:common_github_search/src/models/github_user.dart';

class SearchResultItem {
  final String fullName;
  final String htmlUrl;
  final GithubUser owner;

  const SearchResultItem({
    required this.fullName,
    required this.htmlUrl,
    required this.owner,
  });

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      SearchResultItem(
        fullName: json['full_name'] as String,
        htmlUrl: json['html_url'] as String,
        owner: GithubUser.fromJson(json['owner'] as Map<String, dynamic>),
      );
}
