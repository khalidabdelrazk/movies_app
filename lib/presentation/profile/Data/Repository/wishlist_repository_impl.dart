import 'package:injectable/injectable.dart';
import 'package:movies/presentation/profile/Data/Data%20Sources/remote/get_wishlist_remote_data_source.dart';
import 'package:movies/presentation/profile/Domain/entitys/wishlist_entity.dart';
import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';

import '../../Domain/repository/wishlist_repository.dart';

@Injectable(as: WishlistRepository)
class WishlistRepositoryImpl extends WishlistRepository {
  final GetWishlistRemoteDataSource getWishlistRemoteDataSource;

  WishlistRepositoryImpl({required this.getWishlistRemoteDataSource});

  @override
  Future<Either<Failures, WishlistEntity>> getWishlist() {
    return getWishlistRemoteDataSource.getWishlist();
  }

  // @override
  // Future<Either<Failures, GetProfileResponseEntity>> getProfile() async {
  //   var either = await getProfileRemoteDataSource.getProfile();
  //   return either.fold((error) => Left(error), (response) => Right(response));
  // }
}
