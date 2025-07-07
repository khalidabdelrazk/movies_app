import 'package:injectable/injectable.dart';
import 'package:movies/presentation/profile%20update/data/data_sources/remote/update_profile_remote_data_source.dart';
import 'package:movies/presentation/profile%20update/domain/entitys/update_profile_response_entity.dart';
import 'package:movies/presentation/profile%20update/domain/repository/update_profile_repository.dart';
import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';

@Injectable(as: UpdateProfileRepository)
class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  final UpdateProfileRemoteDataSource updateProfileRemoteDataSource;

  UpdateProfileRepositoryImpl({required this.updateProfileRemoteDataSource});

  @override
  Future<Either<Failures, UpdateProfileResponseEntity>> update(
      {required String name,
      required String email,
      required int avaterId}) async {
    var either = await updateProfileRemoteDataSource.update(
        email: email, name: name, avaterId: avaterId);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
