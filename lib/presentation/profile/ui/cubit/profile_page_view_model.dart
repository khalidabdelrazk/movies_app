import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/profile/Domain/entitys/wishlist_entity.dart';
import 'package:movies/presentation/profile/Domain/use_cases/profile_get_use_case.dart';
import 'package:movies/presentation/profile/Domain/use_cases/wishlist_use_case.dart';
import 'package:movies/presentation/profile/ui/cubit/profile_page_states.dart';

@injectable
class ProfilePageViewModel extends Cubit<ProfilePageStates> {
  final ProfileGetUseCase profileGetUseCase;
  final WishlistUseCase wishlistUseCase;

  WishlistEntity? response;

  ProfilePageViewModel({
    required this.profileGetUseCase,
    required this.wishlistUseCase,
  }) : super(ProfileInitialState());

  /// Loads user profile data
  Future<void> getData() async {
    emit(ProfileLoadingState());
    final result = await profileGetUseCase.invoke();

    result.fold(
      (error) => emit(ProfileErrorState(failures: error)),
      (profileData) => emit(ProfileSuccessState(getProfileResponseEntity: profileData)),
    );
  }

  /// Loads the user's wishlist
  Future<void> getWishList() async {
    emit(ProfileLoadingState());
    final result = await wishlistUseCase.invoke();

    result.fold(
      (error) => emit(WishlistErrorState(failures: error)),
      (success) {
        response = success;
        emit(WishlistSuccessState(wishlistEntity: success));
      },
    );
  }
}
