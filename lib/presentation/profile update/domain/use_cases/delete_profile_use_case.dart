import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/delete_response_entity.dart';
import 'package:movies/presentation/profile%20update/domain/repository/delete_profile_repository.dart';

@injectable
class DeleteProfileUseCase {
  DeleteProfileRepository deleteProfileRepository;

  DeleteProfileUseCase({required this.deleteProfileRepository});

  Future<Either<Failures, DeleteResponseEntity>> invoke() {
    return deleteProfileRepository.delete();
  }
}



