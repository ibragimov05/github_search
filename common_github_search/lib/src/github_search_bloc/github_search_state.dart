part of 'github_search_bloc.dart';

sealed class GithubSearchState extends Equatable {
  const GithubSearchState();

  @override
  List<Object> get props => [];
}

final class SearchStateEmpty extends GithubSearchState {
  const SearchStateEmpty();
}

final class SearchStateLoading extends GithubSearchState {
  const SearchStateLoading();
}

final class SearchStateSuccess extends GithubSearchState {
  final List<SearchResultItem> items;

  const SearchStateSuccess({required this.items});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

final class SearchStateError extends GithubSearchState {
  final String error;

  const SearchStateError({required this.error});

  @override
  List<Object> get props => [error];
}
