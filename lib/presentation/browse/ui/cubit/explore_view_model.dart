import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/browse/Domain/Entity/explore_response_entity.dart';
import 'package:movies/presentation/browse/Domain/Use%20Case/explore_use_case.dart';
import 'package:movies/presentation/browse/ui/cubit/explore_states.dart';

import '../../../../core/constants/constants.dart';

@injectable
class ExploreViewModel extends HydratedCubit<ExploreStates> {
  final ExploreUseCase exploreUseCase;

  String currentGenre = 'Action';
  int currentPage = 1;
  final int limit = 6;
  bool isLoadingMore = false;
  final ScrollController scrollController = ScrollController();
  final ScrollController chipsScrollController = ScrollController();
  late List<GlobalKey> chipKeys;

  String selectedGenre = genre[0];

  List<MoviesExploreEntity> allMovies = [];

  ExploreViewModel({required this.exploreUseCase}) : super(ExploreLoadingState());

  /// Fetch movies for the first time (new genre)
  void fetchInitialMovies(String genre) async {
    emit(ExploreLoadingState());

    currentGenre = genre;
    currentPage = 1;
    allMovies.clear();

    final result = await exploreUseCase.invoke(
      genre: genre,
      limit: limit,
      page: currentPage,
    );

    result.fold(
          (failure) => emit(ExploreErrorState(errMessage: failure.errorMessage)),
          (response) {
        final fetchedMovies = response.data?.movies ?? [];
        allMovies = List<MoviesExploreEntity>.from(fetchedMovies);

        emit(ExploreSuccessState(
          exploreResponseEntity: response.copyWith(movies: allMovies),
        ));
      },
    );
  }


  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore) {
      fetchMoreMovies();
    }
  }

  void scrollToSelectedChip(int index) {
    final keyContext = chipKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }



  /// Fetch more movies for current genre (pagination)
  Future<void> fetchMoreMovies() async {
    if (isLoadingMore) return;

    isLoadingMore = true;
    currentPage++;

    final result = await exploreUseCase.invoke(
      genre: currentGenre,
      limit: limit,
      page: currentPage,
    );

    result.fold(
          (failure) {
        isLoadingMore = false;
        emit(ExploreErrorState(errMessage: failure.errorMessage));
      },
          (response) {
        final fetchedMovies = response.data?.movies ?? [];
        allMovies.addAll(List<MoviesExploreEntity>.from(fetchedMovies));
        isLoadingMore = false;

        emit(ExploreSuccessState(
          exploreResponseEntity: response.copyWith(movies: allMovies),
        ));
      },
    );
  }

  /// Restore from cache (hydrated_bloc)
  @override
  ExploreStates? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == 'success') {
        return ExploreSuccessState(
          exploreResponseEntity: ExploreResponseEntity.fromJson(json['data']),
        );
      } else if (json['state'] == 'error') {
        return ExploreErrorState(errMessage: json['message']);
      } else {
        return ExploreLoadingState();
      }
    } catch (_) {
      return null;
    }
  }

  /// Save to cache (hydrated_bloc)
  @override
  Map<String, dynamic>? toJson(ExploreStates state) {
    if (state is ExploreSuccessState) {
      return {
        'state': 'success',
        'data': state.exploreResponseEntity.toJson(),
      };
    } else if (state is ExploreErrorState) {
      return {
        'state': 'error',
        'message': state.errMessage,
      };
    } else if (state is ExploreLoadingState) {
      return {'state': 'loading'};
    }
    return null;
  }
}
