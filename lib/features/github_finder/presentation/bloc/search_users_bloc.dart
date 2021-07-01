import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/domain/usecases/search_users.dart';
import 'package:injectable/injectable.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

@injectable
class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final SearchUsers _usecase;

  SearchUsersBloc(this._usecase) : super(SearchUsersInitial());

  @override
  Stream<SearchUsersState> mapEventToState(
    SearchUsersEvent event,
  ) async* {
    if (event is SearchUsersStarted) {
      yield SearchUsersInProgress();

      final result = await _usecase(event.queryParam);

      yield* result.fold(
        (failure) async* {
          yield SearchUsersFailure();
        },
        (users) async* {
          yield SearchUsersSuccess(users);
        },
      );
    }
  }
}
