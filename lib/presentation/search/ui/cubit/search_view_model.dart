import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';
import 'package:movies/presentation/search/Domain/Use%20Case/search_use_case.dart';
import 'package:movies/presentation/search/ui/cubit/search_states.dart';

@injectable
class SearchViewModel extends HydratedCubit<SearchStates> {
  final SearchUseCase searchUseCase;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  int currentPage = 1;
  final int limit = 10;
  String lastQuery = '';
  bool isFetchingMore = false;
  bool hasMoreData = true;

  SearchViewModel({required this.searchUseCase}) : super(SearchLoadingState());

  void getMoviesByQuery({
    required String queryTerm,
    required int limit,
    required int page,
  }) async {
    if (page == 1 && state is! SearchSuccessState) {
      emit(SearchLoadingState());
    }

    final result = await searchUseCase.invoke(
      queryTerm: queryTerm,
      limit: limit,
      page: page,
    );

    result.fold(
          (failure) {
        isFetchingMore = false;
        emit(SearchErrorState(message: failure.errorMessage));
      },
          (response) {
        final newMovies = response.data?.movies ?? [];
        hasMoreData = newMovies.length >= limit;

        if (page == 1) {
          emit(SearchSuccessState(searchResponseEntity: response));
        } else {
          final currentState = state;
          if (currentState is SearchSuccessState) {
            final oldData = currentState.searchResponseEntity.data! as DataSearchEntity;
            final updatedData = oldData.copyWith(
              movies: [...oldData.movies ?? [], ...newMovies],
            );

            final updatedEntity = currentState.searchResponseEntity.copyWith(
              data: updatedData,
            );

            emit(SearchSuccessState(searchResponseEntity: updatedEntity));
          }
        }

        isFetchingMore = false;
      },
    );
  }

  void onSearch(String query) {
    lastQuery = query;
    currentPage = 1;
    hasMoreData = true;
    getMoviesByQuery(queryTerm: query, limit: limit, page: currentPage);
  }

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300 &&
        !isFetchingMore &&
        hasMoreData &&
        state is SearchSuccessState) {
      isFetchingMore = true;
      currentPage++;
      getMoviesByQuery(
        queryTerm: lastQuery,
        limit: limit,
        page: currentPage,
      );
    }
  }

  @override
  SearchStates? fromJson(Map<String, dynamic> json) {
    try {
      lastQuery = json['lastQuery'] ?? '';
      currentPage = json['currentPage'] ?? 1;

      if (json['state'] == 'success') {
        return SearchSuccessState(
          searchResponseEntity: SearchResponseEntity.fromJson(json['data']),
        );
      } else if (json['state'] == 'error') {
        return SearchErrorState(message: json['message']);
      } else {
        return SearchLoadingState();
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SearchStates state) {
    if (state is SearchSuccessState) {
      return {
        'state': 'success',
        'data': state.searchResponseEntity.toJson(),
        'lastQuery': lastQuery,
        'currentPage': currentPage,
      };
    } else if (state is SearchErrorState) {
      return {
        'state': 'error',
        'message': state.message,
      };
    } else if (state is SearchLoadingState) {
      return {
        'state': 'loading',
      };
    }
    return null;
  }
}
