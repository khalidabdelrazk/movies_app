import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
abstract class HomeStates {}

class MostPopularLoadingState extends HomeStates {}

class MostPopularErrorState extends HomeStates {
  final String message;
  MostPopularErrorState({required this.message});
}

class MostPopularSuccessState extends HomeStates {
  final MoviesResponseEntity moviesResponseEntity;
  MostPopularSuccessState({required this.moviesResponseEntity});
}

class GenreLoadingState extends HomeStates {
  final String genre;
  GenreLoadingState(this.genre);
}

class GenreErrorState extends HomeStates {
  final String genre;
  final String message;
  GenreErrorState({required this.genre, required this.message});
}

class GenreSuccessState extends HomeStates {
  final String genre;
  final MoviesResponseEntity moviesResponseEntity;
  GenreSuccessState({required this.genre, required this.moviesResponseEntity});
}

// class HomeLoadingState extends HomeStates{}
