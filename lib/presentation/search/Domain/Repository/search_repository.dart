import 'package:either_dart/either.dart';
import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';
import '../../../../core/model/failures.dart';

abstract class SearchRepository {
  Future<Either<Failures, SearchResponseEntity>> getMoviesByQuery({required String queryTerm, required num limit, required num page, });
}
