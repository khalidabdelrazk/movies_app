import '../../Domain/Entity/add_fav_response_entity.dart';

class AddFavResponseDm extends AddFavResponseEntity{
  AddFavResponseDm({
    super.message,
    super.data,});

  AddFavResponseDm.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? DataFavDm.fromJson(json['data']) : null;
  }
}

class DataFavDm extends DataFavEntity{
  DataFavDm({
    super.movieId,
    super.name,
    super.rating,
    super.imageURL,
    super.year,});

  DataFavDm.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
}