import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/search_users_bloc.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search by Github username',
          suffixIcon: Icon(Icons.search_rounded),
        ),
        onSubmitted: (String value) {
          context.read<SearchUsersBloc>().add(
                SearchUsersStarted(value),
              );
        },
      ),
    );
  }
}
