import 'package:dartz/dartz.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/domain/repositories/github_finder_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchUsers {
  final IGithubFinderRepository _repository;

  const SearchUsers(this._repository);

  Future<Either<Failure, List<GithubUser>>> call(String queryParam) async {
    return await _repository.searchUsers(queryParam);
  }
}
