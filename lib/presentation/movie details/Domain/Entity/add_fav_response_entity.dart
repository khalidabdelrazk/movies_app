class AddFavResponseEntity {
  AddFavResponseEntity({
      this.message, 
      this.data,});

  AddFavResponseEntity.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? DataFavEntity.fromJson(json['data']) : null;
  }
  String? message;
  DataFavEntity? data;

}

class DataFavEntity {
  DataFavEntity({
      this.movieId, 
      this.name, 
      this.rating, 
      this.imageURL, 
      this.year,});

  DataFavEntity.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
  String? movieId;
  String? name;
  num? rating;
  String? imageURL;
  String? year;
}