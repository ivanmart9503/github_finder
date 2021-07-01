import 'dart:convert';

import 'package:github_finder/core/errors/exceptions.dart';
import 'package:github_finder/features/github_finder/data/models/github_repo_model.dart';
import 'package:github_finder/features/github_finder/data/models/github_user_model.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

abstract class IGithubFinderRemoteDataSource {
  Future<List<GithubUser>> searchUsers(String queryParam);
  Future<List<GithubRepo>> loadUserRepos(String username);
}

@LazySingleton(as: IGithubFinderRemoteDataSource)
class GithubFinderRemoteDataSource implements IGithubFinderRemoteDataSource {
  final http.Client client;

  GithubFinderRemoteDataSource(this.client);

  @override
  Future<List<GithubUser>> searchUsers(String queryParam) async {
    final url = Uri.parse('https://api.github.com/search/users?q=$queryParam');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> usersList = jsonDecode(response.body)['items'];
      return usersList.map((e) => GithubUserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GithubRepo>> loadUserRepos(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username/repos');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> reposList = jsonDecode(response.body);
      return reposList.map((e) => GithubRepoModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
