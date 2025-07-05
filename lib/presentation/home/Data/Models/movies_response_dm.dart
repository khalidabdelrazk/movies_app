import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';

class MoviesResponseDm extends MoviesResponseEntity {
  MoviesResponseDm({
      super.status,
      super.statusMessage,
      super.data,
      this.message,
      super.meta,});

  MoviesResponseDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataDm.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaDm.fromJson(json['@meta']) : null;
  }
  String? message;
}

class MetaDm extends MetaEntity {
  MetaDm({
      super.serverTime,
      super.serverTimezone,
      super.apiVersion,
      super.executionTime,});

  MetaDm.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}

class DataDm extends DataEntity {
  DataDm({
      super.movieCount,
      super.limit,
      super.pageNumber,
      super.movies,});

  DataDm.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesDm.fromJson(v));
      });
    }
  }
}

class MoviesDm extends MoviesEntity{
  MoviesDm({
      super.id,
      super.url,
      super.imdbCode,
      super.title,
      super.titleEnglish,
      super.titleLong,
      super.slug,
      super.year,
      super.rating,
      super.runtime,
      super.genres,
      super.summary,
      super.descriptionFull,
      super.synopsis,
      super.ytTrailerCode,
      super.language,
      super.mpaRating,
      super.backgroundImage,
      super.backgroundImageOriginal,
      super.smallCoverImage,
      super.mediumCoverImage,
      super.largeCoverImage,
      super.state,
      super.torrents,
      super.dateUploaded,
      super.dateUploadedUnix,});

  MoviesDm.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(TorrentsDm.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }


}

class TorrentsDm extends TorrentsEntity {
  TorrentsDm({
      super.url,
      super.hash,
      super.quality,
      super.type,
      super.isRepack,
      super.videoCodec,
      super.bitDepth,
      super.audioChannels,
      super.seeds,
      super.peers,
      super.size,
      super.sizeBytes,
      super.dateUploaded,
      super.dateUploadedUnix,});

  TorrentsDm.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

}