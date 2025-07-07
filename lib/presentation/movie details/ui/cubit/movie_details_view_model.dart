import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:movies/presentation/movie%20details/Domain/Use%20Case/add_fav_use_case.dart';
import 'package:movies/presentation/movie%20details/Domain/Use%20Case/movie_details_use_case.dart';
import 'package:movies/presentation/movie%20details/Domain/Use%20Case/movie_suggestion_use_case.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_states.dart';

@injectable
class MovieDetailsViewModel extends HydratedCubit<MovieDetailsStates> {
  final MovieDetailsUseCase movieDetailsUseCase;
  final MovieSuggestionUseCase movieSuggestionUseCase;
  final AddFavUseCase addFavUseCase;


  MovieDetailsViewModel(this.movieSuggestionUseCase, this.addFavUseCase, {required this.movieDetailsUseCase})
      : super(MovieDetailsInitState());

  void getMovieDetails({required String imdbId, required bool isFavourite, required num movieId}) async {
    emit(MovieDetailsLoadingState());

    final result = await movieDetailsUseCase.invoke(imdbId, isFavourite, movieId);

    result.fold(
      (failure) => emit(MovieDetailsErrorState(errMsg: failure.errorMessage)),
      (response) =>
          emit(MovieDetailsSuccessState(movieDetailsResponseEntity: response)),
    );
  }

    void getMovieSuggestion({required String imdbId}) async {
    emit(MovieSuggestionLoadingState());

    final result = await movieSuggestionUseCase.invoke(imdbId);

    result.fold(
      (failure) => emit(MovieSuggestionErrorState(errMsg: failure.errorMessage)),
      (response) =>
          emit(MovieSuggestionSuccessState(movieSuggestionResponseEntity: response)),
    );
  }


  Future<void> addToFav({required MovieDetailsResponseEntity movie, required bool isFavourite}) async {
    await addFavUseCase.invoke(movie, isFavourite);
  }

  @override
  MovieDetailsStates? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == 'success') {
        return MovieDetailsSuccessState(
          movieDetailsResponseEntity:
              MovieDetailsResponseEntity.fromJson(json['data']),
        );
      } else if (json['state'] == 'error') {
        return MovieDetailsErrorState(errMsg: json['message']);
      } else {
        return MovieDetailsLoadingState();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(MovieDetailsStates state) {
    if (state is MovieDetailsSuccessState) {
      return {
        'state': 'success',
        'data': state.movieDetailsResponseEntity.toJson(),
      };
    } else if (state is MovieDetailsErrorState) {
      return {
        'state': 'error',
        'message': state.errMsg,
      };
    } else if (state is MovieDetailsLoadingState) {
      return {
        'state': 'loading',
      };
    }
    return null;
  }
}
