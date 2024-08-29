import 'package:common_github_search/common_github_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: <Widget>[
          _SearchBar(),
          _SearchBody(),
        ],
      );
}

class _SearchBar extends StatefulWidget {
  const _SearchBar();

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  late GithubSearchBloc _gitHubSearchBloc;

  @override
  void initState() {
    super.initState();
    _gitHubSearchBloc = context.read<GithubSearchBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  void _onClearTap() {
    _textController.text = '';
    _gitHubSearchBloc.add(const TextChanged(text: ''));
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: _textController,
        autocorrect: false,
        onChanged: (text) => _gitHubSearchBloc.add(TextChanged(text: text)),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            onTap: _onClearTap,
            child: const Icon(Icons.clear),
          ),
        ),
      );
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GithubSearchBloc, GithubSearchState>(
        builder: (context, githubSearchState) => switch (githubSearchState) {
          SearchStateEmpty() => const Text('Please enter a term to begin'),
          SearchStateLoading() => const CircularProgressIndicator.adaptive(),
          SearchStateError() => Text(githubSearchState.error),
          SearchStateSuccess() => githubSearchState.items.isEmpty
              ? const Text('No Results')
              : Expanded(child: _SearchResults(items: githubSearchState.items)),
        },
      );
}

class _SearchResults extends StatelessWidget {
  final List<SearchResultItem> items;

  const _SearchResults({required this.items});

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => _SearchResultItem(
          item: items[index],
        ),
      );
}

class _SearchResultItem extends StatelessWidget {
  final SearchResultItem item;

  const _SearchResultItem({required this.item});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: CircleAvatar(
          child: Image.network(item.owner.avatarUrl),
        ),
        title: Text(item.fullName),
        onTap: () => launchUrl(Uri.parse(item.htmlUrl)),
      );
}
