import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/load_user_repos_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/failure_message.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/initial_message.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/load_user_repos/repo_tile.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/loading.dart';

class ReposList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadUserReposBloc, LoadUserReposState>(
      builder: (context, state) {
        if (state is LoadUserReposInitial) {
          return InitialMessage('Loading repositories');
        }

        if (state is LoadUserReposInProgress) {
          return Loading();
        }

        if (state is LoadUserReposSuccess) {
          return ListView.separated(
            itemCount: state.repos.length,
            separatorBuilder: (context, int i) {
              return Divider(
                indent: 10,
                endIndent: 10,
              );
            },
            itemBuilder: (context, int i) {
              return RepoTile(state.repos[i]);
            },
          );
        }

        if (state is LoadUserReposFailure) {
          return FailureMessage('This user does not have public repositories');
        }

        return Container();
      },
    );
  }
}
