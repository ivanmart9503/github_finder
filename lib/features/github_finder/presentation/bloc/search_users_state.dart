part of 'search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();

  @override
  List<Object> get props => [];
}

class SearchUsersInitial extends SearchUsersState {}

class SearchUsersInProgress extends SearchUsersState {}

class SearchUsersSuccess extends SearchUsersState {
  final List<GithubUser> users;

  SearchUsersSuccess(this.users);

  @override
  List<Object> get props => [users];
}

class SearchUsersFailure extends SearchUsersState {}
