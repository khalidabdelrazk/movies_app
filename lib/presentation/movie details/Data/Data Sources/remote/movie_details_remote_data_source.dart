import 'package:either_dart/either.dart';
import 'package:movies/presentation/movie%20details/Data/Models/add_fav_response_dm.dart';
import 'package:movies/presentation/movie%20details/Data/Models/movie_suggestion_response_dm.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/movie_details_response_entity.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(
      String imdbId, bool isFavourite,  num movieId);
  Future<Either<Failures, MovieSuggestionResponseDm>> getMovieSuggestion(
      String movieId);
  Future<Either<Failures, AddFavResponseDm>> addToFav(MovieDetailsResponseEntity movie,bool isFavourite);
}
