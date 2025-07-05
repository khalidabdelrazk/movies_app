import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

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
