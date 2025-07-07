import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/reset_password_entity.dart';

abstract class ResetPasswordRepository {
  Future<Either<Failures, ResetPasswordEntity>> reset(
      {required String oldPassword, required String newPassword});
}
