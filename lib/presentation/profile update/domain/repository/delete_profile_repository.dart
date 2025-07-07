import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/delete_response_entity.dart';

abstract class DeleteProfileRepository {
  Future<Either<Failures, DeleteResponseEntity>> delete();
}
