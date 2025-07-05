import 'package:either_dart/either.dart';
import '../../../../core/model/failures.dart';
import '../Entity/movies_response_entity.dart';

abstract class HomeRepository {
  Future<Either<Failures, MoviesResponseEntity>> getMostPopular(String? genre);
}
