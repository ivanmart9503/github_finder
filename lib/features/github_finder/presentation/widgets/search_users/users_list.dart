import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/search_users_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/failure_message.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/initial_message.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/loading.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/search_users/user_card.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        if (state is SearchUsersInitial) {
          return InitialMessage('Try searching users');
        }

        if (state is SearchUsersInProgress) {
          return Loading();
        }

        if (state is SearchUsersSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.users.length,
            itemBuilder: (context, int i) {
              return UserCard(state.users[i]);
            },
          );
        }

        if (state is SearchUsersFailure) {
          return FailureMessage('No users found, try with another username');
        }

        return Container();
      },
    );
  }
}
