// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

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
import '../../presentation/browse/Data/Data%20Sources/remote/explore_remote_data_source.dart'
    as _i280;
import '../../presentation/browse/Data/Data%20Sources/remote/impl/explore_remote_data_source_impl.dart'
    as _i523;
import '../../presentation/browse/Data/Repository/explore_repository_impl.dart'
    as _i506;
import '../../presentation/browse/Domain/Repository/explore_repository.dart'
    as _i433;
import '../../presentation/browse/Domain/Use%20Case/explore_use_case.dart'
    as _i679;
import '../../presentation/browse/ui/cubit/explore_view_model.dart' as _i524;
import '../../presentation/home/Data/Data%20Sources/remote/home_remote_data_source.dart'
    as _i252;
import '../../presentation/home/Data/Data%20Sources/remote/impl/home_remote_data_source_impl.dart'
    as _i769;
import '../../presentation/home/Data/Repository/home_repository_impl.dart'
    as _i971;
import '../../presentation/home/Domain/Repository/home_repository.dart' as _i33;
import '../../presentation/home/Domain/Use%20Case/home_use_case.dart' as _i1003;
import '../../presentation/home/ui/cubit/home_view_model.dart' as _i46;
import '../../presentation/movie%20details/Data/Data%20Sources/remote/impl/movie_details_remote_data_source_impl.dart'
    as _i859;
import '../../presentation/movie%20details/Data/Data%20Sources/remote/movie_details_remote_data_source.dart'
    as _i649;
import '../../presentation/movie%20details/Data/Repository/movie_details_repository_impl.dart'
    as _i376;
import '../../presentation/movie%20details/Domain/Repository/movie_details_repository.dart'
    as _i240;
import '../../presentation/movie%20details/Domain/Use%20Case/add_fav_use_case.dart'
    as _i895;
import '../../presentation/movie%20details/Domain/Use%20Case/movie_details_use_case.dart'
    as _i843;
import '../../presentation/movie%20details/Domain/Use%20Case/movie_suggestion_use_case.dart'
    as _i235;
import '../../presentation/movie%20details/ui/cubit/movie_details_view_model.dart'
    as _i755;
import '../../presentation/search/Data/Data%20Sources/remote/impl/search_remote_data_source_impl.dart'
    as _i233;
import '../../presentation/search/Data/Data%20Sources/remote/search_remote_data_source.dart'
    as _i628;
import '../../presentation/search/Data/Repository/search_repository_impl.dart'
    as _i959;
import '../../presentation/search/Domain/Repository/search_repository.dart'
    as _i1006;
import '../../presentation/search/Domain/Use%20Case/search_use_case.dart'
    as _i586;
import '../../presentation/search/ui/cubit/search_view_model.dart' as _i183;
import '../api%20manager/api_manager.dart' as _i949;
import 'modules/dio_module.dart' as _i983;

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
    final dioModules = _$DioModules();
    gh.lazySingleton<_i361.Dio>(() => dioModules.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModules.providePrettyDioLogger());
    gh.factory<_i949.ApiManager>(() => _i949.ApiManager(gh<_i361.Dio>()));
    gh.factory<_i280.ExploreRemoteDataSource>(() =>
        _i523.ExploreRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i433.ExploreRepository>(() => _i506.ExploreRepositoryImpl(
        exploreRemoteDataSource: gh<_i280.ExploreRemoteDataSource>()));
    gh.factory<_i252.HomeRemoteDataSource>(() =>
        _i769.HomeRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i628.SearchRemoteDataSource>(() =>
        _i233.SearchRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i649.MovieDetailsRemoteDataSource>(() =>
        _i859.MovieDetailsRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i293.AuthRemoteDataSource>(() =>
        _i1054.AuthRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i33.HomeRepository>(() => _i971.HomeRepositoryImpl(
        homeRemoteDataSource: gh<_i252.HomeRemoteDataSource>()));
    gh.factory<_i471.AuthRepository>(() => _i659.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i293.AuthRemoteDataSource>()));
    gh.factory<_i679.ExploreUseCase>(() =>
        _i679.ExploreUseCase(exploreRepository: gh<_i433.ExploreRepository>()));
    gh.factory<_i240.MovieDetailsRepository>(() =>
        _i376.MovieDetailsRepositoryImpl(
            movieDetailsRemoteDataSource:
                gh<_i649.MovieDetailsRemoteDataSource>()));
    gh.factory<_i1006.SearchRepository>(() => _i959.SearchRepositoryImpl(
        searchRemoteDataSource: gh<_i628.SearchRemoteDataSource>()));
    gh.factory<_i586.SearchUseCase>(() =>
        _i586.SearchUseCase(searchRepository: gh<_i1006.SearchRepository>()));
    gh.factory<_i1003.HomeUseCase>(
        () => _i1003.HomeUseCase(homeRepository: gh<_i33.HomeRepository>()));
    gh.factory<_i183.SearchViewModel>(
        () => _i183.SearchViewModel(searchUseCase: gh<_i586.SearchUseCase>()));
    gh.factory<_i524.ExploreViewModel>(() =>
        _i524.ExploreViewModel(exploreUseCase: gh<_i679.ExploreUseCase>()));
    gh.factory<_i105.AuthUseCase>(
        () => _i105.AuthUseCase(authRepository: gh<_i471.AuthRepository>()));
    gh.factory<_i895.AddFavUseCase>(() => _i895.AddFavUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i843.MovieDetailsUseCase>(() => _i843.MovieDetailsUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i235.MovieSuggestionUseCase>(() => _i235.MovieSuggestionUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i755.MovieDetailsViewModel>(() => _i755.MovieDetailsViewModel(
          gh<_i235.MovieSuggestionUseCase>(),
          gh<_i895.AddFavUseCase>(),
          movieDetailsUseCase: gh<_i843.MovieDetailsUseCase>(),
        ));
    gh.factory<_i46.HomeViewModel>(
        () => _i46.HomeViewModel(homeUseCase: gh<_i1003.HomeUseCase>()));
    gh.factory<_i212.AuthViewModel>(
        () => _i212.AuthViewModel(authUseCase: gh<_i105.AuthUseCase>()));
    return this;
  }
}

class _$DioModules extends _i983.DioModules {}
