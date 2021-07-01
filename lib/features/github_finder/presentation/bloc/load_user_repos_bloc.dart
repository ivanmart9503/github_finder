import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/usecases/load_user_repos.dart';
import 'package:injectable/injectable.dart';

part 'load_user_repos_event.dart';
part 'load_user_repos_state.dart';

@injectable
class LoadUserReposBloc extends Bloc<LoadUserReposEvent, LoadUserReposState> {
  final LoadUserRepos _usecase;

  LoadUserReposBloc(this._usecase) : super(LoadUserReposInitial());

  @override
  Stream<LoadUserReposState> mapEventToState(
    LoadUserReposEvent event,
  ) async* {
    if (event is LoadUserReposStarted) {
      yield LoadUserReposInProgress();

      final result = await _usecase(event.username);

      yield* result.fold(
        (failure) async* {
          yield LoadUserReposFailure();
        },
        (users) async* {
          yield LoadUserReposSuccess(users);
        },
      );
    }
  }
}
