import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';
import 'package:movies/presentation/search/Domain/Use%20Case/search_use_case.dart';
import 'package:movies/presentation/search/ui/cubit/search_states.dart';

@injectable
class SearchViewModel extends HydratedCubit<SearchStates> {
  final SearchUseCase searchUseCase;

  SearchViewModel({required this.searchUseCase}) : super(SearchLoadingState());

  void getMoviesByQuery({
    required String queryTerm,
    required num limit,
    required num page,
  }) async {
    if (page == 1) emit(SearchLoadingState());

    final result = await searchUseCase.invoke(
      queryTerm: queryTerm,
      limit: limit,
      page: page,
    );

    result.fold(
          (failure) => emit(SearchErrorState(message: failure.errorMessage)),
          (response) {
        if (page == 1) {
          emit(SearchSuccessState(searchResponseEntity: response));
        } else {
          final currentState = state;
          if (currentState is SearchSuccessState) {
            final oldData = currentState.searchResponseEntity.data as DataSearchEntity;
            final newData = response.data as DataSearchEntity;

            final updatedData = oldData.copyWith(
              movies: [...oldData.movies ?? [], ...newData.movies ?? []],
            );

            final updatedEntity = currentState.searchResponseEntity.copyWith(
              data: updatedData,
            );

            emit(SearchSuccessState(searchResponseEntity: updatedEntity));
          }
        }
      },
    );
  }


  @override
  SearchStates? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == 'success') {
        return SearchSuccessState(
          searchResponseEntity: SearchResponseEntity.fromJson(json['data']),
        );
      } else if (json['state'] == 'error') {
        return SearchErrorState(message: json['message']);
      } else {
        return SearchLoadingState();
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SearchStates state) {
    if (state is SearchSuccessState) {
      return {
        'state': 'success',
        'data': state.searchResponseEntity.toJson(),
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
