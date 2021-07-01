import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/repositories/github_finder_repository.dart';
import 'package:github_finder/features/github_finder/domain/usecases/load_user_repos.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubFinderRepository extends Mock
    implements IGithubFinderRepository {}

void main() {
  late MockGithubFinderRepository mockRepository;
  late LoadUserRepos usecase;

  setUp(() {
    mockRepository = MockGithubFinderRepository();
    usecase = LoadUserRepos(mockRepository);
  });

  final tUsername = 'ivanmart';
  final tRepos = [
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
    'should get a [List<GithubRepo>] from the repository',
    () async {
      // Arrange
      when(() => mockRepository.loadUserRepos(any()))
          .thenAnswer((_) async => Right(tRepos));

      // Act
      final result = await usecase(tUsername);

      // Assert
      expect(result, Right(tRepos));
      verify(() => mockRepository.loadUserRepos(tUsername));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
