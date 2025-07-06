
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';

class MovieSuggestionResponseEntity {
  String? status;
  String? statusMessage;
  DataMovieSuggestion? data;
  MetaMovieSuggestion? meta;

  MovieSuggestionResponseEntity({this.status, this.statusMessage, this.data, this.meta});

  MovieSuggestionResponseEntity.fromJson(Map<String, dynamic> json) {
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["status_message"] is String) {
      statusMessage = json["status_message"];
    }
    if(json["data"] is Map) {
      data = json["data"] == null ? null : DataMovieSuggestion.fromJson(json["data"]);
    }
    if(json["@meta"] is Map) {
      meta = json["@meta"] == null ? null : MetaMovieSuggestion.fromJson(json["@meta"]);
    }
  }

  static List<MovieSuggestionResponseEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(MovieSuggestionResponseEntity.fromJson).toList();
  }

}

class MetaMovieSuggestion {
  int? serverTime;
  String? serverTimezone;
  int? apiVersion;
  String? executionTime;

  MetaMovieSuggestion({this.serverTime, this.serverTimezone, this.apiVersion, this.executionTime});

  MetaMovieSuggestion.fromJson(Map<String, dynamic> json) {
    if(json["server_time"] is int) {
      serverTime = json["server_time"];
    }
    if(json["server_timezone"] is String) {
      serverTimezone = json["server_timezone"];
    }
    if(json["api_version"] is int) {
      apiVersion = json["api_version"];
    }
    if(json["execution_time"] is String) {
      executionTime = json["execution_time"];
    }
  }

  static List<MetaMovieSuggestion> fromList(List<Map<String, dynamic>> list) {
    return list.map(MetaMovieSuggestion.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["server_time"] = serverTime;
    data["server_timezone"] = serverTimezone;
    data["api_version"] = apiVersion;
    data["execution_time"] = executionTime;
    return data;
  }
}

class DataMovieSuggestion extends DataEntity {


  DataMovieSuggestion({super.movieCount, super.movies});

  DataMovieSuggestion.fromJson(Map<String, dynamic> json) {
    if(json["movie_count"] is int) {
      movieCount = json["movie_count"];
    }
    if(json["movies"] is List) {
      movies = json["movies"] == null ? null : (json["movies"] as List).map((e) => MoviesMovieSuggestionEntity.fromJson(e)).toList();
    }
  }

  static List<DataMovieSuggestion> fromList(List<Map<String, dynamic>> list) {
    return list.map(DataMovieSuggestion.fromJson).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["movie_count"] = movieCount;
    if(movies != null) {
      data["movies"] = movies?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class MoviesMovieSuggestionEntity extends MoviesEntity{

  MoviesMovieSuggestionEntity({super.id, super.url, super.imdbCode, super.title, super.titleEnglish, super.titleLong, super.slug, super.year, super.rating, super.runtime, super.genres, super.summary, super.descriptionFull, super.synopsis, super.ytTrailerCode, super.language, super.mpaRating, super.backgroundImage, super.backgroundImageOriginal, super.smallCoverImage, super.mediumCoverImage, super.state, super.torrents, super.dateUploaded, super.dateUploadedUnix});

  MoviesMovieSuggestionEntity.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["imdb_code"] is String) {
      imdbCode = json["imdb_code"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["title_english"] is String) {
      titleEnglish = json["title_english"];
    }
    if(json["title_long"] is String) {
      titleLong = json["title_long"];
    }
    if(json["slug"] is String) {
      slug = json["slug"];
    }
    if(json["year"] is int) {
      year = json["year"];
    }
    if(json["rating"] is double) {
      rating = json["rating"];
    }
    if(json["runtime"] is int) {
      runtime = json["runtime"];
    }
    if(json["genres"] is List) {
      genres = json["genres"] == null ? null : List<String>.from(json["genres"]);
    }
    if(json["summary"] is String) {
      summary = json["summary"];
    }
    if(json["description_full"] is String) {
      descriptionFull = json["description_full"];
    }
    if(json["synopsis"] is String) {
      synopsis = json["synopsis"];
    }
    if(json["yt_trailer_code"] is String) {
      ytTrailerCode = json["yt_trailer_code"];
    }
    if(json["language"] is String) {
      language = json["language"];
    }
    if(json["mpa_rating"] is String) {
      mpaRating = json["mpa_rating"];
    }
    if(json["background_image"] is String) {
      backgroundImage = json["background_image"];
    }
    if(json["background_image_original"] is String) {
      backgroundImageOriginal = json["background_image_original"];
    }
    if(json["small_cover_image"] is String) {
      smallCoverImage = json["small_cover_image"];
    }
    if(json["medium_cover_image"] is String) {
      mediumCoverImage = json["medium_cover_image"];
    }
    if(json["state"] is String) {
      state = json["state"];
    }
    if(json["torrents"] is List) {
      torrents = json["torrents"] == null ? null : (json["torrents"] as List).map((e) => TorrentsMovieSyggestion.fromJson(e)).toList();
    }
    if(json["date_uploaded"] is String) {
      dateUploaded = json["date_uploaded"];
    }
    if(json["date_uploaded_unix"] is int) {
      dateUploadedUnix = json["date_uploaded_unix"];
    }
  }

  static List<MoviesMovieSuggestionEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(MoviesMovieSuggestionEntity.fromJson).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["url"] = url;
    data["imdb_code"] = imdbCode;
    data["title"] = title;
    data["title_english"] = titleEnglish;
    data["title_long"] = titleLong;
    data["slug"] = slug;
    data["year"] = year;
    data["rating"] = rating;
    data["runtime"] = runtime;
    if(genres != null) {
      data["genres"] = genres;
    }
    data["summary"] = summary;
    data["description_full"] = descriptionFull;
    data["synopsis"] = synopsis;
    data["yt_trailer_code"] = ytTrailerCode;
    data["language"] = language;
    data["mpa_rating"] = mpaRating;
    data["background_image"] = backgroundImage;
    data["background_image_original"] = backgroundImageOriginal;
    data["small_cover_image"] = smallCoverImage;
    data["medium_cover_image"] = mediumCoverImage;
    data["state"] = state;
    if(torrents != null) {
      data["torrents"] = torrents?.map((e) => e.toJson()).toList();
    }
    data["date_uploaded"] = dateUploaded;
    data["date_uploaded_unix"] = dateUploadedUnix;
    return data;
  }
}

class TorrentsMovieSyggestion extends TorrentsEntity {

  TorrentsMovieSyggestion({super.url, super.hash, super.quality, super.isRepack, super.videoCodec, super.bitDepth, super.audioChannels, super.seeds, super.peers, super.size, super.sizeBytes, super.dateUploaded, super.dateUploadedUnix});

  TorrentsMovieSyggestion.fromJson(Map<String, dynamic> json) {
    if(json["url"] is String) {
      url = json["url"];
    }
    if(json["hash"] is String) {
      hash = json["hash"];
    }
    if(json["quality"] is String) {
      quality = json["quality"];
    }
    if(json["is_repack"] is String) {
      isRepack = json["is_repack"];
    }
    if(json["video_codec"] is String) {
      videoCodec = json["video_codec"];
    }
    if(json["bit_depth"] is String) {
      bitDepth = json["bit_depth"];
    }
    if(json["audio_channels"] is String) {
      audioChannels = json["audio_channels"];
    }
    if(json["seeds"] is int) {
      seeds = json["seeds"];
    }
    if(json["peers"] is int) {
      peers = json["peers"];
    }
    if(json["size"] is String) {
      size = json["size"];
    }
    if(json["size_bytes"] is int) {
      sizeBytes = json["size_bytes"];
    }
    if(json["date_uploaded"] is String) {
      dateUploaded = json["date_uploaded"];
    }
    if(json["date_uploaded_unix"] is int) {
      dateUploadedUnix = json["date_uploaded_unix"];
    }
  }

  static List<TorrentsMovieSyggestion> fromList(List<Map<String, dynamic>> list) {
    return list.map(TorrentsMovieSyggestion.fromJson).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["url"] = url;
    data["hash"] = hash;
    data["quality"] = quality;
    data["is_repack"] = isRepack;
    data["video_codec"] = videoCodec;
    data["bit_depth"] = bitDepth;
    data["audio_channels"] = audioChannels;
    data["seeds"] = seeds;
    data["peers"] = peers;
    data["size"] = size;
    data["size_bytes"] = sizeBytes;
    data["date_uploaded"] = dateUploaded;
    data["date_uploaded_unix"] = dateUploadedUnix;
    return data;
  }
}