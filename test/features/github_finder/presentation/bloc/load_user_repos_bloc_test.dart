import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/usecases/load_user_repos.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/load_user_repos_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockLoadUserRepos extends Mock implements LoadUserRepos {}

void main() {
  late MockLoadUserRepos mockLoadUserRepos;
  late LoadUserReposBloc bloc;

  setUp(() {
    mockLoadUserRepos = MockLoadUserRepos();
    bloc = LoadUserReposBloc(mockLoadUserRepos);
  });

  tearDown(() {
    bloc.close();
  });

  final tUsername = 'ivanmart';
  final tGithubRepos = [
    GithubRepo(
      id: 12638890,
      name: "bootstrap-datepicker",
      description:
          "A datepicker for @twitter bootstrap forked from Stefan Petre's (of eyecon.ro), improvements by @eternicode",
      language: "JavaScript",
    ),
    GithubRepo(
      id: 308864817,
      name: "ecom",
      description: "Ecom project",
      language: "JavaScript",
    ),
  ];

  test(
    'initial state should be [LoadUserReposInitial]',
    () async {
      // Assert
      expect(bloc.state, equals(LoadUserReposInitial()));
    },
  );

  blocTest(
    '''should emit [LoadUserReposInProgress, LoadUserReposSuccess] 
    when data is gotten successfully''',
    build: () {
      when(() => mockLoadUserRepos(any()))
          .thenAnswer((_) async => Right(tGithubRepos));
      return bloc;
    },
    act: (_) => bloc.add(LoadUserReposStarted(tUsername)),
    verify: (_) {
      verify(() => mockLoadUserRepos(tUsername));
    },
    expect: () => [
      LoadUserReposInProgress(),
      LoadUserReposSuccess(tGithubRepos),
    ],
  );

  blocTest(
    '''should emit [LoadUserReposInProgress, LoadUserReposFailure] 
    when getting data fails''',
    build: () {
      when(() => mockLoadUserRepos(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      return bloc;
    },
    act: (_) => bloc.add(LoadUserReposStarted(tUsername)),
    verify: (_) {
      verify(() => mockLoadUserRepos(tUsername));
    },
    expect: () => [
      LoadUserReposInProgress(),
      LoadUserReposFailure(),
    ],
  );
}
