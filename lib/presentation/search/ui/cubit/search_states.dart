import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';

abstract class SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchErrorState extends SearchStates {
  final String message;
  SearchErrorState({required this.message});
}

class SearchSuccessState extends SearchStates {
  final SearchResponseEntity searchResponseEntity;
  SearchSuccessState({required this.searchResponseEntity});
}

