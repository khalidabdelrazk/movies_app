import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_suggestion_response_entity.dart';
import '../../../../core/model/failures.dart';
import '../Repository/movie_details_repository.dart';

@injectable
class MovieSuggestionUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  MovieSuggestionUseCase({required this.movieDetailsRepository});
  Future<Either<Failures, MovieSuggestionResponseEntity>> invoke(
    String movieId,
  ) {
    return movieDetailsRepository.getMovieSuggestion(movieId);
  }
}
