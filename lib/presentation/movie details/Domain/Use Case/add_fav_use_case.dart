import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import '../../../../core/model/failures.dart';
import '../Entity/add_fav_response_entity.dart';
import '../Repository/movie_details_repository.dart';

@injectable
class AddFavUseCase {
  final MovieDetailsRepository movieDetailsRepository;
  AddFavUseCase({required this.movieDetailsRepository});
  Future<Either<Failures, AddFavResponseEntity>> invoke(
      MovieDetailsResponseEntity movie, bool isFavourite) {
    return movieDetailsRepository.addToFav(movie, isFavourite);
  }
}
