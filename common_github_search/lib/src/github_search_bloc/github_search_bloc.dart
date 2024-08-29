import 'package:bloc/bloc.dart';
import 'package:common_github_search/common_github_search.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../models/search_result_item.dart';

part 'github_search_event.dart';

part 'github_search_state.dart';

const Duration _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) =>
    (events, mapper) => events.debounce(duration).switchMap(mapper);

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  final GithubRepository _githubRepository;

  GithubSearchBloc({
    required GithubRepository githubRepository,
  })  : _githubRepository = githubRepository,
        super(const SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<GithubSearchState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(const SearchStateEmpty());

    emit(const SearchStateLoading());

    try {
      final result = await _githubRepository.search(searchTerm);
      emit(SearchStateSuccess(items: result.items));
    } catch (error) {
      emit(
        error is SearchResultError
            ? SearchStateError(error: error.message)
            : const SearchStateError(error: 'something went wrong'),
      );
    }
  }
}
