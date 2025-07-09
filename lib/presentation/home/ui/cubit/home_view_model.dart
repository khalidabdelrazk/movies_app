import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../Domain/Use Case/home_use_case.dart';
import 'home_states.dart';

@injectable
class HomeViewModel extends HydratedCubit<HomeStates> {
  final HomeUseCase homeUseCase;

  // Cache for genre-based movie lists
  Map<String, MoviesResponseEntity> _genreCache = {};

  HomeViewModel({required this.homeUseCase})
      : super(MostPopularLoadingState());

  void getMostPopularMovies({String? genre}) async {
    final key = genre ?? 'general';

    // Load from memory if available
    if (_genreCache.containsKey(key)) {
      emit(MostPopularSuccessState(moviesResponseEntity: _genreCache[key]!));
      return;
    }

    emit(MostPopularLoadingState());

    final result = await homeUseCase.invoke(genre);

    result.fold(
          (failure) =>
          emit(MostPopularErrorState(message: failure.errorMessage)),
          (response) {
        _genreCache[key] = response;
        emit(MostPopularSuccessState(moviesResponseEntity: response));
      },
    );
  }

  @override
  HomeStates? fromJson(Map<String, dynamic> json) {
    try {
      _genreCache = (json['genres'] as Map<String, dynamic>).map(
            (key, value) =>
            MapEntry(key, MoviesResponseEntity.fromJson(value)),
      );
      return MostPopularSuccessState(
        moviesResponseEntity: _genreCache['general'] ??
            MoviesResponseEntity(data: DataEntity(movies: [])),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeStates state) {
    return {
      'genres': _genreCache.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}
