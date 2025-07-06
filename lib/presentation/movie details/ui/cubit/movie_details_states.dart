import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_suggestion_response_entity.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInitState extends MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsSuccessState extends MovieDetailsStates {
  MovieDetailsResponseEntity movieDetailsResponseEntity;
  MovieDetailsSuccessState({required this.movieDetailsResponseEntity});
}

class MovieDetailsErrorState extends MovieDetailsStates {
  String? errMsg;
  MovieDetailsErrorState({this.errMsg});
}

class MovieSuggestionLoadingState extends MovieDetailsStates {}

class MovieSuggestionSuccessState extends MovieDetailsStates {
  MovieSuggestionResponseEntity movieSuggestionResponseEntity;
  MovieSuggestionSuccessState({required this.movieSuggestionResponseEntity});
}

class MovieSuggestionErrorState extends MovieDetailsStates {
  String? errMsg;
  MovieSuggestionErrorState({this.errMsg});
}