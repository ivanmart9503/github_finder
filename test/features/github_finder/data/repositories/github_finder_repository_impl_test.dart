import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/core/errors/exceptions.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/core/network/network_info.dart';
import 'package:github_finder/features/github_finder/data/datasources/github_finder_remote_data_source.dart';
import 'package:github_finder/features/github_finder/data/models/github_repo_model.dart';
import 'package:github_finder/features/github_finder/data/models/github_user_model.dart';
import 'package:github_finder/features/github_finder/data/repositories/github_finder_repository.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockRemoteDataSource extends Mock
    implements IGithubFinderRemoteDataSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late GithubFinderRepository repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GithubFinderRepository(
      mockRemoteDataSource,
      mockNetworkInfo,
    );
  });

  group('searchUsers', () {
    final tQueryParam = 'ivanmart';
    final tGithubUsersModels = [
      GithubUserModel(
        id: 3215384,
        login: 'ivanmart',
        avatar: 'https://avatars.githubusercontent.com/u/3215384?v=4',
      ),
      GithubUserModel(
        id: 35318080,
        login: 'ivanmartinezmorales',
        avatar: 'https://avatars.githubusercontent.com/u/35318080?v=4',
      ),
    ];
    final List<GithubUser> tGithubUsers = tGithubUsersModels;

    test(
      'should check if the device has connection to the internet',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.searchUsers(any()))
            .thenAnswer((_) async => tGithubUsersModels);

        // Act
        repository.searchUsers(tQueryParam);

        // Assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.searchUsers(any()))
            .thenAnswer((_) async => tGithubUsersModels);

        // Act
        final result = await repository.searchUsers(tQueryParam);

        // Assert
        verify(() => mockRemoteDataSource.searchUsers(tQueryParam));
        expect(result, equals(Right(tGithubUsers)));
      },
    );

    test(
      'should return [ServerFailure] when the call to remote data source is unsuccessful',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.searchUsers(any()))
            .thenThrow(ServerException());

        // Act
        final result = await repository.searchUsers(tQueryParam);

        // Assert
        verify(() => mockRemoteDataSource.searchUsers(tQueryParam));
        expect(result, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return [ConnectionFailure] when the device is not online',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // Act
        final result = await repository.searchUsers(tQueryParam);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ConnectionFailure())));
      },
    );
  });

  group('loadUserRepos', () {
    final tUsername = 'ivanmart';
    final tGithubReposModels = [
      GithubRepoModel(
        id: 12638890,
        name: "bootstrap-datepicker",
        description:
            "A datepicker for @twitter bootstrap forked from Stefan Petre's (of eyecon.ro), improvements by @eternicode",
        language: "JavaScript",
      ),
      GithubRepoModel(
        id: 308864817,
        name: "ecom",
        description: "Ecom project",
        language: "JavaScript",
      ),
    ];
    final List<GithubRepo> tGithubRepos = tGithubReposModels;

    test(
      'should check if the device has connection to the internet',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.loadUserRepos(any()))
            .thenAnswer((_) async => tGithubReposModels);

        // Act
        repository.loadUserRepos(tUsername);

        // Assert
        verify(() => mockNetworkInfo.isConnected);
      },
    );

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.loadUserRepos(any()))
            .thenAnswer((_) async => tGithubReposModels);

        // Act
        final result = await repository.loadUserRepos(tUsername);

        // Assert
        verify(() => mockRemoteDataSource.loadUserRepos(tUsername));
        expect(result, equals(Right(tGithubRepos)));
      },
    );

    test(
      'should return [ServerFailure] when the call to remote data source is unsuccessful',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDataSource.loadUserRepos(any()))
            .thenThrow(ServerException());

        // Act
        final result = await repository.loadUserRepos(tUsername);

        // Assert
        verify(() => mockRemoteDataSource.loadUserRepos(tUsername));
        expect(result, equals(Left(ServerFailure())));
      },
    );

    test(
      'should return [ConnectionFailure] when the device is not online',
      () async {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // Act
        final result = await repository.loadUserRepos(tUsername);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ConnectionFailure())));
      },
    );
  });
}
