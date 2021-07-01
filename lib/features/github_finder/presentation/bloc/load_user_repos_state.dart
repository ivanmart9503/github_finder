part of 'load_user_repos_bloc.dart';

abstract class LoadUserReposState extends Equatable {
  const LoadUserReposState();

  @override
  List<Object> get props => [];
}

class LoadUserReposInitial extends LoadUserReposState {}

class LoadUserReposInProgress extends LoadUserReposState {}

class LoadUserReposSuccess extends LoadUserReposState {
  final List<GithubRepo> repos;

  LoadUserReposSuccess(this.repos);

  @override
  List<Object> get props => [repos];
}

class LoadUserReposFailure extends LoadUserReposState {}
