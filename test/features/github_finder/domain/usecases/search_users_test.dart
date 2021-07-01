import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/domain/repositories/github_finder_repository.dart';
import 'package:github_finder/features/github_finder/domain/usecases/search_users.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubFinderRepository extends Mock
    implements IGithubFinderRepository {}

void main() {
  late MockGithubFinderRepository mockRepository;
  late SearchUsers usecase;

  setUp(() {
    mockRepository = MockGithubFinderRepository();
    usecase = SearchUsers(mockRepository);
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
    'should get a [List<GithubUser>] from the repository',
    () async {
      // Arrange
      when(() => mockRepository.searchUsers(any()))
          .thenAnswer((_) async => Right(tGithubUsers));

      // Act
      final result = await usecase(tQueryParam);

      // Assert
      expect(result, equals(Right(tGithubUsers)));
      verify(() => mockRepository.searchUsers(tQueryParam));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
