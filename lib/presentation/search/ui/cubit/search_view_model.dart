import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';
import 'package:movies/presentation/search/Domain/Use%20Case/search_use_case.dart';
import 'package:movies/presentation/search/ui/cubit/search_states.dart';

@injectable
class SearchViewModel extends HydratedCubit<SearchStates> {
  final SearchUseCase searchUseCase;

  SearchViewModel({required this.searchUseCase}) : super(SearchLoadingState());

  void ggetMoviesByQuery({required String queryTerm, required num limit, required num page, }) async {
    emit(SearchLoadingState());

    final result = await searchUseCase.invoke(queryTerm: queryTerm, limit: limit, page: page);

    result.fold(
          (failure) => emit(SearchErrorState(message: failure.errorMessage)),
          (response) => emit(SearchSuccessState(searchResponseEntity: response)),
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
