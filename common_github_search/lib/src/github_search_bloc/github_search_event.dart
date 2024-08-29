part of 'github_search_bloc.dart';

sealed class GithubSearchEvent extends Equatable {
  const GithubSearchEvent();
}

final class TextChanged extends GithubSearchEvent {
  final String text;

  const TextChanged({required this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged {text: $text}';
}
