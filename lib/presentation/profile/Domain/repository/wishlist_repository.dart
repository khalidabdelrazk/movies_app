import 'package:either_dart/either.dart';
import 'package:movies/core/model/failures.dart';
import 'package:movies/presentation/profile/Domain/entitys/wishlist_entity.dart';

abstract class WishlistRepository {
  
  Future<Either<Failures, WishlistEntity>> getWishlist();
}
