import 'package:movies/presentation/browse/Domain/Entity/explore_response_entity.dart';

abstract class ExploreStates {}

class ExploreLoadingState extends ExploreStates {}

class ExploreErrorState extends ExploreStates {
  String errMessage;
  ExploreErrorState({required this.errMessage});
}

class ExploreSuccessState extends ExploreStates {
  ExploreResponseEntity exploreResponseEntity;
  ExploreSuccessState({required this.exploreResponseEntity});
}
