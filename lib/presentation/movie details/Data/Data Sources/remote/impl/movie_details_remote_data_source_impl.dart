import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/core/utils/shared_pref_services.dart';
import 'package:movies/presentation/movie%20details/Data/Models/add_fav_response_dm.dart';
import 'package:movies/presentation/movie%20details/Data/Models/movie_details_response_dm.dart';
import 'package:movies/presentation/movie%20details/Data/Models/movie_suggestion_response_dm.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import '../../../../../../core/api manager/api_endpoints.dart';
import '../../../../../../core/api manager/api_manager.dart';
import '../movie_details_remote_data_source.dart';

@Injectable(as: MovieDetailsRemoteDataSource)
class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  ApiManager apiManager;
  MovieDetailsRemoteDataSourceImpl({required this.apiManager});

  @override
  @override
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(
      String imdbId, bool isFavourite, num movieId) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (!connectivityResult.contains(ConnectivityResult.none)) {

        SharedPrefService sharedPrefService = SharedPrefService.instance;
        String token = sharedPrefService.getToken() ?? "0";

        // Get favorite status
        final isLiked = await apiManager.getData(
          path: ApiEndpoints.isFavorite(movieId),
          options: Options(
            validateStatus: (status) => true,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),

        );

        // Get movie details
        final response = await apiManager.getData(
          path: ApiEndpoints.movieDetails,
          queryParameters: {
            "imdb_id": imdbId,
            "with_cast": true,
            "with_images": true,
          },
          options: Options(
            validateStatus: (status) => true,
          ),
        );



        final movieDetailsResponseDm = MovieDetailsResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300 && isLiked.statusCode! >= 200 && isLiked.statusCode! < 300) {
          // ✅ Inject the isFavourite manually into the entity model (if supported)
          movieDetailsResponseDm.isFavourite = isLiked.data["data"];
          return Right(movieDetailsResponseDm);
        }

        return Left(ServerError(
          errorMessage: movieDetailsResponseDm.message ?? "Unknown error",
        ));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, MovieSuggestionResponseDm>> getMovieSuggestion(
      String movieId) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.getData(
          path: ApiEndpoints.movieSuggestions,
          queryParameters: {
            "movie_id": movieId,
          },
          options: Options(
            validateStatus: (status) => true,
          ),
        );
        MovieSuggestionResponseDm movieSuggestionResponseDm =
            MovieSuggestionResponseDm.fromJson(
          response.data,
        );
        // print("RESPONSE BODY: ${response.data}");
        // print("STATUS CODE: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(movieSuggestionResponseDm);
        }
        return Left(
            ServerError(errorMessage: movieSuggestionResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      // rethrow;
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AddFavResponseDm>> addToFav(MovieDetailsResponseEntity movie, bool isFavourite) async{
    if(isFavourite){
      return _addToFav(movie);
    }else{
      return _removeFav(movie);
    }
  }

  Future<Either<Failures, AddFavResponseDm>> _addToFav(MovieDetailsResponseEntity movie) async{
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        MovieMovieDetails movieMovieDetails = movie.data!.movie!;

        SharedPrefService sharedPrefService = SharedPrefService.instance;
        String token = sharedPrefService.getToken() ?? "0";
          var response = await apiManager.postData(
            path: ApiEndpoints.addToFavorites,
            data: {
              "movieId": movieMovieDetails.id,
              "name": movieMovieDetails.title,
              "rating": movieMovieDetails.rating,
              "imageURL": movieMovieDetails.largeCoverImage,
              "year": movieMovieDetails.year
            },
            options: Options(
              validateStatus: (status) => true,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          );


        AddFavResponseDm movieSuggestionResponseDm =
        AddFavResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(movieSuggestionResponseDm);
        }
        return Left(
            ServerError(errorMessage: movieSuggestionResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      // rethrow;
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  Future<Either<Failures, AddFavResponseDm>> _removeFav(MovieDetailsResponseEntity movie) async{
    final List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        MovieMovieDetails movieMovieDetails = movie.data!.movie!;
        SharedPrefService sharedPrefService = SharedPrefService.instance;
        String token = sharedPrefService.getToken() ?? "0";


         var response = await apiManager.deleteData(
            path: ApiEndpoints.removeFavorite(movieMovieDetails.id!),
            options: Options(
              validateStatus: (status) => true,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          );

        AddFavResponseDm movieSuggestionResponseDm =
        AddFavResponseDm.fromJson(
          response.data,
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(movieSuggestionResponseDm);
        }
        return Left(
            ServerError(errorMessage: movieSuggestionResponseDm.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      // rethrow;
      return Left(ServerError(errorMessage: e.toString()));
    }
  }


}

/*
  @override
  Future<Either<Failures, RegisterResponseEntity>> register(
      String? name,
      String? email,
      String? password,
      String? rePassword,
      String? phone,
      int? avatarId) async {
    print(
        'name: $name,email: $email,password: $password,rePassword: $rePassword,phone: $phone,avaterId: $avatarId');
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiEndpoints.register,
          data: {
            "name": name,
            "email": email,
            "password": password,
            "confirmPassword": rePassword,
            "phone": phone,
            "avaterId": avatarId
          },
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        RegisterResponseDm registerResponse = RegisterResponseDm.fromJson(
          response.data,
        );
        print("RESPONSE BODY: ${response.data}");
        print("STATUS CODE: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        }
        return Left(ServerError(errorMessage: registerResponse.message!));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      print('Hello');
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(
      String? email, String? password) async {
    print('email: $email,password: $password,');
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.ethernet) ||
          connectivityResult.contains(ConnectivityResult.vpn) ||
          connectivityResult.contains(ConnectivityResult.bluetooth) ||
          connectivityResult.contains(ConnectivityResult.other) ||
          !connectivityResult.contains(ConnectivityResult.none) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response = await apiManager.postData(
          path: ApiEndpoints.login,
          data: {
            "email": email,
            "password": password,
          },
          options: Options(
            headers: {"Content-Type": "application/json"},
            validateStatus: (status) => true,
          ),
        );
        LoginResponseDm loginResponseDm = LoginResponseDm.fromJson(
          response.data,
        );
        print("RESPONSE BODY: ${response.data}");
        print("STATUS CODE: ${response.statusCode}");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponseDm);
        }
        return Left(ServerError(
            errorMessage: _extractMessage(loginResponseDm.message)));
      } else {
        return Left(NetworkError(errorMessage: "Network Error"));
      }
    } catch (e) {
      print('Hello');
      return Left(ServerError(errorMessage: e.toString()));
    }
  }

  String _extractMessage(dynamic message) {
    if (message is String) {
      return message;
    } else if (message is List) {
      return message.join('\n');
    } else {
      return "Unexpected error occurred";
    }
  }
 */
