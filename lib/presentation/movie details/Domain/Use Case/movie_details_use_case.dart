import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/movie_details_response_entity.dart';
import '../Repository/movie_details_repository.dart';

@injectable
class HomeUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  HomeUseCase({required this.movieDetailsRepository});
  Future<Either<Failures, MovieDetailsResponseEntity>> invoke(String imdbId,) {
    return movieDetailsRepository.getMovieDetails(imdbId);
  }
}
