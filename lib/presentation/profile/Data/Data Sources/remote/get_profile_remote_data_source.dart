import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile/Domain/entitys/GetProfileResponseEntity.dart';

//todo:interface
abstract class GetProfileRemoteDataSource {
  Future<Either<Failures, GetProfileResponseEntity>> getProfile();
}
