import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../../Domain/Entity/movies_response_entity.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, MoviesResponseEntity>> getMostPopular(String? genre);

}
