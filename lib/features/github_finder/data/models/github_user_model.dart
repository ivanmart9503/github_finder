import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';

class GithubUserModel extends GithubUser {
  GithubUserModel({
    required int id,
    required String login,
    required String avatar,
  }) : super(id: id, login: login, avatar: avatar);

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      id: json['id'] ?? 0,
      login: json['login'] ?? 'unknown',
      avatar: json['avatar_url'] ?? '',
    );
  }
}
