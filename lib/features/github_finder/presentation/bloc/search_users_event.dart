part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();

  @override
  List<Object> get props => [];
}

class SearchUsersStarted extends SearchUsersEvent {
  final String queryParam;

  SearchUsersStarted(this.queryParam);

  @override
  List<Object> get props => [queryParam];
}
