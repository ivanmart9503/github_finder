import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_finder/features/github_finder/data/models/github_repo_model.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tGithubRepo = GithubRepoModel(
    id: 12638890,
    name: "bootstrap-datepicker",
    description:
        "A datepicker for @twitter bootstrap forked from Stefan Petre's (of eyecon.ro), improvements by @eternicode",
    language: "JavaScript",
  );

  test(
    'should be a subclass of [GithubRepo]',
    () async {
      // Assert
      expect(tGithubRepo, isA<GithubRepo>());
    },
  );

  test(
    'should return a valid [GithubRepoModel] from JSON',
    () async {
      // Arrange
      final Map<String, dynamic> json = jsonDecode(
        fixture('github_user_repo.json'),
      );

      // Act
      final result = GithubRepoModel.fromJson(json);

      // Assert
      expect(result, equals(tGithubRepo));
    },
  );
}
