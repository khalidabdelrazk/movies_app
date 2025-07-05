import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';

abstract class HomeStates {}

class MostPopularLoadingState extends HomeStates {}

class MostPopularErrorState extends HomeStates {
  String? message;
  MostPopularErrorState({this.message = "null Value"});
}

class MostPopularSuccessState extends HomeStates {
  MoviesResponseEntity moviesResponseEntity;
  MostPopularSuccessState({required this.moviesResponseEntity});
}
// class HomeLoadingState extends HomeStates{}
