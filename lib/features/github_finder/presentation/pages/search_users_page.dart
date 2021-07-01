import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/core/dependency_injection/injection_container.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/search_users_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/search_users/results_text.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/search_users/search_field.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/search_users/users_list.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchUsersBloc>(
      create: (context) => getIt<SearchUsersBloc>(),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text('Search Github Users'),
          centerTitle: true,
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          children: [
            SearchField(),
            ResultsText(),
            UsersList(),
          ],
        ),
      ),
    );
  }
}
