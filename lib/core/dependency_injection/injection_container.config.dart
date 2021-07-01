// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/github_finder/data/datasources/github_finder_remote_data_source.dart'
    as _i4;
import '../../features/github_finder/data/repositories/github_finder_repository.dart'
    as _i7;
import '../../features/github_finder/domain/repositories/github_finder_repository.dart'
    as _i6;
import '../../features/github_finder/domain/usecases/load_user_repos.dart'
    as _i8;
import '../../features/github_finder/domain/usecases/search_users.dart' as _i10;
import '../../features/github_finder/presentation/bloc/load_user_repos_bloc.dart'
    as _i9;
import '../../features/github_finder/presentation/bloc/search_users_bloc.dart'
    as _i11;
import '../network/network_info.dart' as _i5;
import 'third_party_module.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyModule = _$ThirdPartyModule();
  gh.lazySingleton<_i3.Client>(() => thirdPartyModule.client);
  gh.lazySingleton<_i4.IGithubFinderRemoteDataSource>(
      () => _i4.GithubFinderRemoteDataSource(get<_i3.Client>()));
  gh.lazySingleton<_i5.INetworkInfo>(() => _i5.NetworkInfo());
  gh.lazySingleton<_i6.IGithubFinderRepository>(() =>
      _i7.GithubFinderRepository(
          get<_i4.IGithubFinderRemoteDataSource>(), get<_i5.INetworkInfo>()));
  gh.factory<_i8.LoadUserRepos>(
      () => _i8.LoadUserRepos(get<_i6.IGithubFinderRepository>()));
  gh.factory<_i9.LoadUserReposBloc>(
      () => _i9.LoadUserReposBloc(get<_i8.LoadUserRepos>()));
  gh.factory<_i10.SearchUsers>(
      () => _i10.SearchUsers(get<_i6.IGithubFinderRepository>()));
  gh.factory<_i11.SearchUsersBloc>(
      () => _i11.SearchUsersBloc(get<_i10.SearchUsers>()));
  return get;
}

class _$ThirdPartyModule extends _i12.ThirdPartyModule {}
