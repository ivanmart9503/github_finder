import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/features/github_finder/data/models/github_user_model.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tGithubUserModel = GithubUserModel(
    id: 3215384,
    login: 'ivanmart',
    avatar: 'https://avatars.githubusercontent.com/u/3215384?v=4',
  );

  test('should be a subclass of [GithubUser]', () async {
    expect(tGithubUserModel, isA<GithubUser>());
  });

  test(
    'should return a valid [GithubUser] from JSON',
    () async {
      // Arrange
      final Map<String, dynamic> json = jsonDecode(fixture('github_user.json'));

      // Act
      final result = GithubUserModel.fromJson(json);

      // Assert
      expect(result, equals(tGithubUserModel));
    },
  );
}
