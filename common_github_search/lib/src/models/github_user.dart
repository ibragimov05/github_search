class GithubUser {
  final String login;
  final String avatarUrl;

  const GithubUser({
    required this.login,
    required this.avatarUrl,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) => GithubUser(
        login: json['login'] as String,
        avatarUrl: json['avatar_url'] as String,
      );
}
