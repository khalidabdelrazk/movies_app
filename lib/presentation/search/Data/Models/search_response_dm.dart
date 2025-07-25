import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import 'package:movies/presentation/search/Domain/Entity/search_response_entity.dart';

class SearchResponseDm extends SearchResponseEntity {
  SearchResponseDm({
    super.status,
    super.statusMessage,
    super.data,
    this.message,
    super.meta,});

  SearchResponseDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataSearchDm.fromJson(json['data']) : null;
    meta = json['MetaEntity'] != null ? MetaEntity.fromJson(json['MetaEntity']) : null;
  }
  String? message;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['MetaEntity'] = meta?.toJson();
    }
    return map;
  }

}

class MetaSearchDm extends MetaSearchEntity {
  MetaSearchDm({
    super.serverTime,
    super.serverTimezone,
    super.apiVersion,
    super.executionTime,});

  MetaSearchDm.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['server_time'] = serverTime;
    map['server_timezone'] = serverTimezone;
    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;
    return map;
  }

}

class DataSearchDm extends DataSearchEntity {
  DataSearchDm({
    super.movieCount,
    super.limit,
    super.pageNumber,
    super.movies,});

  DataSearchDm.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesSearchDm.fromJson(v));
      });
    }
  }


  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    map['limit'] = limit;
    map['page_number'] = pageNumber;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MoviesSearchDm extends MoviesSearchEntity{
  MoviesSearchDm({
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

  MoviesSearchDm.fromJson(dynamic json) {
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
        torrents?.add(TorrentsSearchDm.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}

class TorrentsSearchDm extends TorrentsSearchEntity {
  TorrentsSearchDm({
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

  TorrentsSearchDm.fromJson(dynamic json) {
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

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}