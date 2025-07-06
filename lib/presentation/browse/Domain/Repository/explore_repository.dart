import 'package:either_dart/either.dart';
import '../../../../core/model/failures.dart';
import '../Entity/explore_response_entity.dart';

abstract class ExploreRepository {
  Future<Either<Failures, ExploreResponseEntity>> getMoviesByGenre(
      {required String genre, required num limit, required num page});
}
