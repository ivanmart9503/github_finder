import 'package:github_finder/core/errors/exceptions.dart';
import 'package:github_finder/core/network/network_info.dart';
import 'package:github_finder/features/github_finder/data/datasources/github_finder_remote_data_source.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_user.dart';
import 'package:github_finder/features/github_finder/domain/entities/github_repo.dart';
import 'package:github_finder/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:github_finder/features/github_finder/domain/repositories/github_finder_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IGithubFinderRepository)
class GithubFinderRepository implements IGithubFinderRepository {
  final IGithubFinderRemoteDataSource _remoteDataSource;
  final INetworkInfo _networkInfo;

  GithubFinderRepository(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<GithubUser>>> searchUsers(
    String queryParam,
  ) async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final users = await _remoteDataSource.searchUsers(queryParam);
        return Right(users);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<GithubRepo>>> loadUserRepos(
    String username,
  ) async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final repos = await _remoteDataSource.loadUserRepos(username);
        return Right(repos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
