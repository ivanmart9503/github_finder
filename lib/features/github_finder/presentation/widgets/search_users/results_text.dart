import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/search_users_bloc.dart';

class ResultsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        if (state is SearchUsersSuccess) {
          final text = state.users.length == 1 ? 'user found' : 'users found';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${state.users.length} $text',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
