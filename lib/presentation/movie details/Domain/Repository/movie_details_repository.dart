import 'package:either_dart/either.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_suggestion_response_entity.dart';
import '../../../../core/model/failures.dart';
import '../Entity/add_fav_response_entity.dart';
import '../Entity/movie_details_response_entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(String imdbId, bool isFavourite, num movieId);
  Future<Either<Failures, MovieSuggestionResponseEntity>> getMovieSuggestion(String movieId);
  Future<Either<Failures, AddFavResponseEntity>> addToFav(MovieDetailsResponseEntity movie, bool isFavourite);

}
