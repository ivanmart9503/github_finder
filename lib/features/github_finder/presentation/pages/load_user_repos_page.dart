import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_finder/core/dependency_injection/injection_container.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/load_user_repos_bloc.dart';
import 'package:github_finder/features/github_finder/presentation/widgets/load_user_repos/repos_list.dart';

class LoadUserReposPage extends StatelessWidget {
  final GithubUser user;

  const LoadUserReposPage(this.user);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadUserReposBloc>(
      create: (context) => getIt<LoadUserReposBloc>()
        ..add(
          LoadUserReposStarted(user.login),
        ),
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(user.login),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Align(
                child: CircleAvatar(
                  foregroundImage: NetworkImage(user.avatar),
                  maxRadius: 20,
                ),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: ReposList(),
      ),
    );
  }
}
