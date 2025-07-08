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
import '../../presentation/profile%20update/data/data_sources/remote/delete_profile_remote_data_source.dart'
    as _i826;
import '../../presentation/profile%20update/data/data_sources/remote/impl/delete_profile_remote_data_source_impl.dart'
    as _i406;
import '../../presentation/profile%20update/data/data_sources/remote/impl/reset_password_remote_data_source_impl.dart'
    as _i45;
import '../../presentation/profile%20update/data/data_sources/remote/impl/update_profile_remote_data_source_impl.dart'
    as _i863;
import '../../presentation/profile%20update/data/data_sources/remote/reset_password_remote_data_source.dart'
    as _i781;
import '../../presentation/profile%20update/data/data_sources/remote/update_profile_remote_data_source.dart'
    as _i696;
import '../../presentation/profile%20update/data/repository/delete_profile_repository_impl.dart'
    as _i710;
import '../../presentation/profile%20update/data/repository/reset_password_repository_impl.dart'
    as _i892;
import '../../presentation/profile%20update/data/repository/update_profile_repository_impl.dart'
    as _i46;
import '../../presentation/profile%20update/domain/repository/delete_profile_repository.dart'
    as _i839;
import '../../presentation/profile%20update/domain/repository/reset_password_repository.dart'
    as _i354;
import '../../presentation/profile%20update/domain/repository/update_profile_repository.dart'
    as _i554;
import '../../presentation/profile%20update/domain/use_cases/delete_profile_use_case.dart'
    as _i120;
import '../../presentation/profile%20update/domain/use_cases/reset_password_use_case.dart'
    as _i233;
import '../../presentation/profile%20update/domain/use_cases/update_profile_use_case.dart'
    as _i533;
import '../../presentation/profile%20update/ui/cubit/profile_update_view_model.dart'
    as _i252;
import '../../presentation/profile/Data/Data%20Sources/remote/get_profile_remote_data_source.dart'
    as _i182;
import '../../presentation/profile/Data/Data%20Sources/remote/get_wishlist_remote_data_source.dart'
    as _i345;
import '../../presentation/profile/Data/Data%20Sources/remote/impl/get_profile_remote_data_source_impl.dart'
    as _i104;
import '../../presentation/profile/Data/Data%20Sources/remote/impl/get_wishlist_remote_data_source_impl.dart'
    as _i333;
import '../../presentation/profile/Data/Repository/profile_repository_impl.dart'
    as _i216;
import '../../presentation/profile/Data/Repository/wishlist_repository_impl.dart'
    as _i268;
import '../../presentation/profile/Domain/repository/profile_repository.dart'
    as _i339;
import '../../presentation/profile/Domain/repository/wishlist_repository.dart'
    as _i187;
import '../../presentation/profile/Domain/use_cases/profile_get_use_case.dart'
    as _i952;
import '../../presentation/profile/Domain/use_cases/wishlist_use_case.dart'
    as _i193;
import '../../presentation/profile/ui/cubit/profile_page_view_model.dart'
    as _i812;
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
    gh.factory<_i781.ResetPasswordRemoteDataSource>(() =>
        _i45.ResetPasswordRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i628.SearchRemoteDataSource>(() =>
        _i233.SearchRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i649.MovieDetailsRemoteDataSource>(() =>
        _i859.MovieDetailsRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i345.GetWishlistRemoteDataSource>(() =>
        _i333.GetWishlistRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i293.AuthRemoteDataSource>(() =>
        _i1054.AuthRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i280.ExploreRemoteDataSource>(() =>
        _i523.ExploreRemoteDataSourceImpl(apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i354.ResetPasswordRepository>(() =>
        _i892.ResetPasswordRepositoryImpl(
            resetPasswordRemoteDataSource:
                gh<_i781.ResetPasswordRemoteDataSource>()));
    gh.factory<_i182.GetProfileRemoteDataSource>(() =>
        _i104.GetProfileRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i696.UpdateProfileRemoteDataSource>(() =>
        _i863.UpdateProfileRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i33.HomeRepository>(() => _i971.HomeRepositoryImpl(
        homeRemoteDataSource: gh<_i252.HomeRemoteDataSource>()));
    gh.factory<_i826.DeleteProfileRemoteDataSource>(() =>
        _i406.DeleteProfileRemoteDataSourceImpl(
            apiManager: gh<_i949.ApiManager>()));
    gh.factory<_i233.ResetPasswordUseCase>(() => _i233.ResetPasswordUseCase(
        resetPasswordRepository: gh<_i354.ResetPasswordRepository>()));
    gh.factory<_i471.AuthRepository>(() => _i659.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i293.AuthRemoteDataSource>()));
    gh.factory<_i240.MovieDetailsRepository>(() =>
        _i376.MovieDetailsRepositoryImpl(
            movieDetailsRemoteDataSource:
                gh<_i649.MovieDetailsRemoteDataSource>()));
    gh.factory<_i1006.SearchRepository>(() => _i959.SearchRepositoryImpl(
        searchRemoteDataSource: gh<_i628.SearchRemoteDataSource>()));
    gh.factory<_i433.ExploreRepository>(() => _i506.ExploreRepositoryImpl(
        exploreRemoteDataSource: gh<_i280.ExploreRemoteDataSource>()));
    gh.factory<_i554.UpdateProfileRepository>(() =>
        _i46.UpdateProfileRepositoryImpl(
            updateProfileRemoteDataSource:
                gh<_i696.UpdateProfileRemoteDataSource>()));
    gh.factory<_i533.UpdateProfileUseCase>(() => _i533.UpdateProfileUseCase(
        updateProfileRepository: gh<_i554.UpdateProfileRepository>()));
    gh.factory<_i339.ProfileRepository>(() => _i216.ProfileRepositoryImpl(
        getProfileRemoteDataSource: gh<_i182.GetProfileRemoteDataSource>()));
    gh.factory<_i952.ProfileGetUseCase>(() => _i952.ProfileGetUseCase(
        profileRepository: gh<_i339.ProfileRepository>()));
    gh.factory<_i187.WishlistRepository>(() => _i268.WishlistRepositoryImpl(
        getWishlistRemoteDataSource: gh<_i345.GetWishlistRemoteDataSource>()));
    gh.factory<_i586.SearchUseCase>(() =>
        _i586.SearchUseCase(searchRepository: gh<_i1006.SearchRepository>()));
    gh.factory<_i1003.HomeUseCase>(
        () => _i1003.HomeUseCase(homeRepository: gh<_i33.HomeRepository>()));
    gh.factory<_i193.WishlistUseCase>(() => _i193.WishlistUseCase(
        wishlistRepository: gh<_i187.WishlistRepository>()));
    gh.factory<_i183.SearchViewModel>(
        () => _i183.SearchViewModel(searchUseCase: gh<_i586.SearchUseCase>()));
    gh.factory<_i839.DeleteProfileRepository>(() =>
        _i710.DeleteProfileRepositoryImpl(
            deleteProfileRemoteDataSource:
                gh<_i826.DeleteProfileRemoteDataSource>()));
    gh.factory<_i105.AuthUseCase>(
        () => _i105.AuthUseCase(authRepository: gh<_i471.AuthRepository>()));
    gh.factory<_i895.AddFavUseCase>(() => _i895.AddFavUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i843.MovieDetailsUseCase>(() => _i843.MovieDetailsUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i235.MovieSuggestionUseCase>(() => _i235.MovieSuggestionUseCase(
        movieDetailsRepository: gh<_i240.MovieDetailsRepository>()));
    gh.factory<_i679.ExploreUseCase>(() =>
        _i679.ExploreUseCase(exploreRepository: gh<_i433.ExploreRepository>()));
    gh.factory<_i120.DeleteProfileUseCase>(() => _i120.DeleteProfileUseCase(
        deleteProfileRepository: gh<_i839.DeleteProfileRepository>()));
    gh.factory<_i252.UpdateProfilePageViewModel>(
        () => _i252.UpdateProfilePageViewModel(
              updateProfileUseCase: gh<_i533.UpdateProfileUseCase>(),
              deleteProfileUseCase: gh<_i120.DeleteProfileUseCase>(),
              resetPasswordUseCase: gh<_i233.ResetPasswordUseCase>(),
            ));
    gh.factory<_i755.MovieDetailsViewModel>(() => _i755.MovieDetailsViewModel(
          gh<_i235.MovieSuggestionUseCase>(),
          gh<_i895.AddFavUseCase>(),
          movieDetailsUseCase: gh<_i843.MovieDetailsUseCase>(),
        ));
    gh.factory<_i46.HomeViewModel>(
        () => _i46.HomeViewModel(homeUseCase: gh<_i1003.HomeUseCase>()));
    gh.factory<_i812.ProfilePageViewModel>(() => _i812.ProfilePageViewModel(
          profileGetUseCase: gh<_i952.ProfileGetUseCase>(),
          wishlistUseCase: gh<_i193.WishlistUseCase>(),
        ));
    gh.factory<_i212.AuthViewModel>(
        () => _i212.AuthViewModel(authUseCase: gh<_i105.AuthUseCase>()));
    gh.factory<_i524.ExploreViewModel>(() =>
        _i524.ExploreViewModel(exploreUseCase: gh<_i679.ExploreUseCase>()));
    return this;
  }
}
