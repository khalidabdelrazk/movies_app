import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_suggestion_response_entity.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Repository/movie_details_repository.dart';
import '../Data Sources/remote/movie_details_remote_data_source.dart';

@Injectable(as: MovieDetailsRepository)
class MovieDetailsRepositoryImpl extends MovieDetailsRepository {
  final MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;
  MovieDetailsRepositoryImpl({required this.movieDetailsRemoteDataSource});

  @override
  Future<Either<Failures, MovieDetailsResponseEntity>> getMovieDetails(String imdbId) {
    return movieDetailsRemoteDataSource.getMovieDetails(imdbId);
  }
  
  @override
  Future<Either<Failures, MovieSuggestionResponseEntity>> getMovieSuggestion(String movieId) {
    return movieDetailsRemoteDataSource.getMovieSuggestion(movieId);
  }


}
