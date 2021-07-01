part of 'load_user_repos_bloc.dart';

abstract class LoadUserReposEvent extends Equatable {
  const LoadUserReposEvent();

  @override
  List<Object> get props => [];
}

class LoadUserReposStarted extends LoadUserReposEvent {
  final String username;

  LoadUserReposStarted(this.username);

  @override
  List<Object> get props => [username];
}
