import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/domain/usecases/search_users.dart';
import 'package:github_finder/features/github_finder/presentation/bloc/search_users_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSearchUsers extends Mock implements SearchUsers {}

void main() {
  late MockSearchUsers mockSearchUsers;
  late SearchUsersBloc bloc;

  setUp(() {
    mockSearchUsers = MockSearchUsers();
    bloc = SearchUsersBloc(mockSearchUsers);
  });

  tearDown(() {
    bloc.close();
  });

  final tQueryParam = 'ivanmart';
  final tGithubUsers = [
    GithubUser(
      id: 3215384,
      login: 'ivanmart',
      avatar: 'https://avatars.githubusercontent.com/u/3215384?v=4',
    ),
    GithubUser(
      id: 35318080,
      login: 'ivanmartinezmorales',
      avatar: 'https://avatars.githubusercontent.com/u/35318080?v=4',
    ),
  ];

  test(
    'initial state should be [SearchUsersInitial]',
    () async {
      // Assert
      expect(bloc.state, equals(SearchUsersInitial()));
    },
  );

  blocTest(
    '''should emit [SearchUsersInProgress, SearchUsersSuccess] 
    when data is gotten successfully''',
    build: () {
      when(() => mockSearchUsers(any()))
          .thenAnswer((_) async => Right(tGithubUsers));
      return bloc;
    },
    act: (_) => bloc.add(SearchUsersStarted(tQueryParam)),
    verify: (_) {
      verify(() => mockSearchUsers(tQueryParam));
    },
    expect: () => [
      SearchUsersInProgress(),
      SearchUsersSuccess(tGithubUsers),
    ],
  );

  blocTest(
    '''should emit [SearchUsersInProgress, SearchUsersFailure] 
    when getting data fails''',
    build: () {
      when(() => mockSearchUsers(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      return bloc;
    },
    act: (_) => bloc.add(SearchUsersStarted(tQueryParam)),
    verify: (_) {
      verify(() => mockSearchUsers(tQueryParam));
    },
    expect: () => [
      SearchUsersInProgress(),
      SearchUsersFailure(),
    ],
  );
}
