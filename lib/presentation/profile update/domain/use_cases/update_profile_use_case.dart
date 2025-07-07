import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/UpdateProfileResponseEnity.dart';
import 'package:movies/presentation/profile%20update/domain/repository/update_profile_repository.dart';

@injectable
class UpdateProfileUseCase {
  UpdateProfileRepository updateProfileRepository;
  UpdateProfileUseCase({required this.updateProfileRepository});

  Future<Either<Failures, UpdateProfileResponseEntity>> invoke(
      {required String name, required String email, required int avaterId}) {
    return updateProfileRepository.update(
        name: name, email: email, avaterId: avaterId);
  }
}
