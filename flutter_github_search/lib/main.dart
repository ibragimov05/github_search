import 'package:common_github_search/common_github_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_search/search_form.dart';

void main() {
  final GithubRepository githubRepository = GithubRepository(
    cache: GithubCache(),
    client: GithubClient(),
  );

  runApp(App(githubRepository: githubRepository));
}

class App extends StatelessWidget {
  final GithubRepository _githubRepository;

  const App({
    super.key,
    required GithubRepository githubRepository,
  }) : _githubRepository = githubRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github search',
      home: Scaffold(
        appBar: AppBar(title: const Text('Github search')),
        body: BlocProvider(
          create: (_) => GithubSearchBloc(githubRepository: _githubRepository),
          child: const SearchForm(),
        ),
      ),
    );
  }
}
