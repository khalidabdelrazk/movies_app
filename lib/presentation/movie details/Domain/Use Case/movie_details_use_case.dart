import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/movie_details_response_entity.dart';
import '../Repository/movie_details_repository.dart';

@injectable
class MovieDetailsUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  MovieDetailsUseCase({required this.movieDetailsRepository});
  Future<Either<Failures, MovieDetailsResponseEntity>> invoke(
    String imdbId,
      bool isFavourite,  num movieId
  ) {
    return movieDetailsRepository.getMovieDetails(imdbId, isFavourite, movieId);
  }
}

