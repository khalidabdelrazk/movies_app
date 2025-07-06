import 'package:either_dart/either.dart';
import '../../../../../core/model/failures.dart';
import '../../Models/search_response_dm.dart';


abstract class SearchRemoteDataSource {
  Future<Either<Failures, SearchResponseDm>> getMoviesByQuery({required String queryTerm, required num limit, required num page, });

}
