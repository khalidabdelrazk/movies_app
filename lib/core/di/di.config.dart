// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../presentation/authentication/Data/Data%20Sources/remote/auth_remote_data_source.dart'
    as _i293;
import '../../presentation/authentication/Data/Data%20Sources/remote/impl/auth_remote_data_source_impl.dart'
    as _i1054;
import '../../presentation/authentication/Data/Repository/auth_repository_impl.dart'
    as _i659;
import '../../presentation/authentication/Domain/Repository/auth_repository.dart'
    as _i471;
import '../../presentation/authentication/Domain/Use%20Case/auth_use_case.dart'
    as _i105;
import '../../presentation/authentication/ui/cubit/authentication/auth_view_model.dart'
    as _i212;
import '../../presentation/home/Data/Data%20Sources/remote/home_remote_data_source.dart'
    as _i252;
import '../../presentation/home/Data/Data%20Sources/remote/impl/home_remote_data_source_impl.dart'
    as _i769;
import '../../presentation/home/Data/Repository/home_repository_impl.dart'
    as _i971;
import '../../presentation/home/Domain/Repository/home_repository.dart' as _i33;
import '../../presentation/home/Domain/Use%20Case/home_use_case.dart' as _i1003;
import '../../presentation/home/ui/cubit/home_view_model.dart' as _i46;
import '../api%20manager/api_manager.dart' as _i949;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i949.ApiManager>(() => _i949.ApiManager());
    gh.factory<_i252.HomeRemoteDataSource>(() =>
        _i769.HomeRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i293.AuthRemoteDataSource>(() =>
        _i1054.AuthRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i33.HomeRepository>(() => _i971.HomeRepositoryImpl(
        homeRemoteDataSource: gh<_i252.HomeRemoteDataSource>()));
    gh.factory<_i471.AuthRepository>(() => _i659.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i293.AuthRemoteDataSource>()));
    gh.factory<_i1003.HomeUseCase>(
        () => _i1003.HomeUseCase(homeRepository: gh<_i33.HomeRepository>()));
    gh.factory<_i105.AuthUseCase>(
        () => _i105.AuthUseCase(authRepository: gh<_i471.AuthRepository>()));
    gh.factory<_i46.HomeViewModel>(
        () => _i46.HomeViewModel(homeUseCase: gh<_i1003.HomeUseCase>()));
    gh.factory<_i212.AuthViewModel>(
        () => _i212.AuthViewModel(authUseCase: gh<_i105.AuthUseCase>()));
    return this;
  }
}
