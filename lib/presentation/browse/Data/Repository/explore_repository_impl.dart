import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/explore_response_entity.dart';
import '../../Domain/Repository/explore_repository.dart';
import '../Data Sources/remote/explore_remote_data_source.dart';

@Injectable(as: ExploreRepository)
class ExploreRepositoryImpl extends ExploreRepository {
  final ExploreRemoteDataSource exploreRemoteDataSource;
  ExploreRepositoryImpl({required this.exploreRemoteDataSource});

  @override
  Future<Either<Failures, ExploreResponseEntity>> getMoviesByGenre({required String genre, required num limit, required num page}) {
    // TODO: implement getMoviesByGenre
    return exploreRemoteDataSource.getMoviesByGenre(genre: genre, limit: limit, page: page);
  }
}
