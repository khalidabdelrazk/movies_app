import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/search_response_entity.dart';
import '../../Domain/Repository/search_repository.dart';
import '../Data Sources/remote/search_remote_data_source.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;
  SearchRepositoryImpl({required this.searchRemoteDataSource});

  @override
  Future<Either<Failures, SearchResponseEntity>> getMoviesByQuery({required String queryTerm, required num limit, required num page}) {
    return searchRemoteDataSource.getMoviesByQuery(queryTerm: queryTerm, limit: limit, page: page);
  }


}
