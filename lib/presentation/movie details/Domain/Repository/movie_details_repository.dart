import 'package:either_dart/either.dart';
import '../../../../core/model/failures.dart';
import '../Entity/movie_details_response_entity.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(String imdbId);
}
