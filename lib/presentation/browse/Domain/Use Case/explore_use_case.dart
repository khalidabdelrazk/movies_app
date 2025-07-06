import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../Entity/explore_response_entity.dart';
import '../Repository/explore_repository.dart';

@injectable
class ExploreUseCase {
  final ExploreRepository exploreRepository;
  ExploreUseCase({required this.exploreRepository});
  Future<Either<Failures, ExploreResponseEntity>> invoke(
      {required String genre, required num limit, required num page}) {
    return exploreRepository.getMoviesByGenre(genre: genre, limit: limit, page: page);
  }
}
