import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/UpdateProfileResponseEnity.dart';

abstract class UpdateProfileRepository {
  Future<Either<Failures, UpdateProfileResponseEntity>> update(
      {required String name, required String email, required int avaterId});
}
