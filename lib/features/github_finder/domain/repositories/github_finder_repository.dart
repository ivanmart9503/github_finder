import 'package:dartz/dartz.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';

abstract class IGithubFinderRepository {
  Future<Either<Failure, List<GithubUser>>> searchUsers(String queryParam);
  Future<Either<Failure, List<GithubRepo>>> loadUserRepos(String username);
}
