import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/model/failures.dart';
import '../../Domain/Entity/movies_response_entity.dart';
import '../../Domain/Repository/home_repository.dart';
import '../Data Sources/remote/home_remote_data_source.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, MoviesResponseEntity>> getMostPopular(String? genre) {
    return homeRemoteDataSource.getMostPopular(genre);
  }


}
