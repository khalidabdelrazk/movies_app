import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../Models/explore_response_dm.dart';

abstract class ExploreRemoteDataSource {
  Future<Either<Failures, ExploreResponseDm>> getMoviesByGenre(
      {required String genre, required num limit, required num page});
}
