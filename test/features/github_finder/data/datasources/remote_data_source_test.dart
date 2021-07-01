import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/core/errors/exceptions.dart';
import 'package:github_finder/features/github_finder/data/datasources/github_finder_remote_data_source.dart';
import 'package:github_finder/features/github_finder/data/models/github_repo_model.dart';
import 'package:github_finder/features/github_finder/data/models/github_user_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockUri extends Mock implements Uri {}

void main() {
  late MockHttpClient mockClient;
  late GithubFinderRemoteDataSource remoteDataSource;

  setUpAll(() {
    registerFallbackValue(MockUri());
  });

  setUp(() {
    mockClient = MockHttpClient();
    remoteDataSource = GithubFinderRemoteDataSource(mockClient);
  });

  group('searchUsers', () {
    final tQueryParam = 'ivanmart';
    final tGithubUsers = [
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

    test(
      '''should return a [List<GithubUserModel>] 
      when the response code is 200 (success)''',
      () async {
        // Arrange
        when(() => mockClient.get(any())).thenAnswer((_) async {
          return http.Response(fixture('github_users.json'), 200);
        });

        // Act
        final result = await remoteDataSource.searchUsers(tQueryParam);

        // Assert
        expect(result, equals(tGithubUsers));
      },
    );

    test(
      '''should return a [ServerException] 
      when the response code is 404 or other''',
      () async {
        // Arrange
        when(() => mockClient.get(any())).thenAnswer((_) async {
          return http.Response('Something went wrong', 500);
        });

        // Act
        final call = remoteDataSource.searchUsers;

        // Assert
        expect(
          () => call(tQueryParam),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('loadUserRepos', () {
    final tUsername = 'ivanmart';
    final tGithubRepos = [
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

    test(
      '''should return a [List<GithubRepoModel>] 
      when the response code is 200 (success)''',
      () async {
        // Arrange
        when(() => mockClient.get(any())).thenAnswer((_) async {
          return http.Response(fixture('github_user_repos.json'), 200);
        });

        // Act
        final result = await remoteDataSource.loadUserRepos(tUsername);

        // Assert
        expect(result, equals(tGithubRepos));
      },
    );

    test(
      '''should return a [ServerException] 
      when the response code is 404 or other''',
      () async {
        // Arrange
        when(() => mockClient.get(any())).thenAnswer((_) async {
          return http.Response('Something went wrong', 500);
        });

        // Act
        final call = remoteDataSource.loadUserRepos;

        // Assert
        expect(
          () => call(tUsername),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
