import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';

class GithubRepoModel extends GithubRepo {
  GithubRepoModel({
    required int id,
    required String name,
    required String description,
    required String language,
  }) : super(
          id: id,
          name: name,
          description: description,
          language: language,
        );

  factory GithubRepoModel.fromJson(Map<String, dynamic> json) {
    return GithubRepoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description provided',
      language: json['language'] ?? '',
    );
  }
}
