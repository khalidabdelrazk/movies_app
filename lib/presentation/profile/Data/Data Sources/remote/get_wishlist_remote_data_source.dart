import 'package:either_dart/either.dart';
import 'package:movies/presentation/profile/Domain/entitys/wishlist_entity.dart';
import 'package:movies/core/model/failures.dart';

//todo:interface
abstract class GetWishlistRemoteDataSource {
  Future<Either<Failures, WishlistEntity>> getWishlist();
}
