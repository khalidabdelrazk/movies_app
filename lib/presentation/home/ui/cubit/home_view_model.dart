import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../Domain/Use Case/home_use_case.dart';
import 'home_states.dart';

@injectable
class HomeViewModel extends HydratedCubit<HomeStates> {
  final HomeUseCase homeUseCase;

  HomeViewModel({required this.homeUseCase}) : super(MostPopularLoadingState());

  void getMostPopularMovies({String? genre}) async {
    emit(MostPopularLoadingState());

    final result = await homeUseCase.invoke(genre);

    result.fold(
          (failure) => emit(MostPopularErrorState(message: failure.errorMessage)),
          (response) => emit(MostPopularSuccessState(moviesResponseEntity: response)),
    );
  }

  @override
  HomeStates? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == 'success') {
        return MostPopularSuccessState(
          moviesResponseEntity: MoviesResponseEntity.fromJson(json['data']),
        );
      } else if (json['state'] == 'error') {
        return MostPopularErrorState(message: json['message']);
      } else {
        return MostPopularLoadingState();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeStates state) {
    if (state is MostPopularSuccessState) {
      return {
        'state': 'success',
        'data': state.moviesResponseEntity.toJson(),
      };
    } else if (state is MostPopularErrorState) {
      return {
        'state': 'error',
        'message': state.message,
      };
    } else if (state is MostPopularLoadingState) {
      return {
        'state': 'loading',
      };
    }
    return null;
  }
}
