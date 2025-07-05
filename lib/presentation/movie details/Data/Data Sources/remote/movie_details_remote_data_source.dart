import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/movie_details_response_entity.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(String imdbId);

}
