import 'package:dartz/dartz.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/features/github_finder/domain/repositories/github_finder_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadUserRepos {
  final IGithubFinderRepository _repository;

  LoadUserRepos(this._repository);

  Future<Either<Failure, List<GithubRepo>>> call(String username) async {
    return await _repository.loadUserRepos(username);
  }
}
