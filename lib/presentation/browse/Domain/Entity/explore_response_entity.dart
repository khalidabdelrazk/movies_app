import '../../../home/Domain/Entity/movies_response_entity.dart';

class ExploreResponseEntity extends MoviesResponseEntity {
  ExploreResponseEntity({
    super.status,
    super.statusMessage,
    super.data,
    super.meta,
  });

  ExploreResponseEntity.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataExploreEntity.fromJson(json['data']) : null;
    meta = json['MetaExploreEntity'] != null
        ? MetaExploreEntity.fromJson(json['MetaExploreEntity'])
        : null;
  }

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

  ExploreResponseEntity copyWith({
    String? status,
    String? statusMessage,
    DataExploreEntity? data,
    MetaExploreEntity? meta,
    List<MoviesExploreEntity>? movies,
  }) {
    final copiedData = (data ?? this.data) as DataExploreEntity?;
    return ExploreResponseEntity(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      data: copiedData?.copyWith(movies: movies),
      meta: meta ?? this.meta as MetaExploreEntity?,
    );
  }
}


class MetaExploreEntity extends MetaEntity {
  MetaExploreEntity({
      super.serverTime,
      super.serverTimezone,
      super.apiVersion,
      super.executionTime,});

  MetaExploreEntity.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

}

class DataExploreEntity extends DataEntity {
  DataExploreEntity({
    super.movieCount,
    super.limit,
    super.pageNumber,
    super.movies,
  });

  DataExploreEntity.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesExploreEntity.fromJson(v));
      });
    }
  }

  DataExploreEntity copyWith({
    int? movieCount,
    int? limit,
    int? pageNumber,
    List<MoviesExploreEntity>? movies,
  }) {
    return DataExploreEntity(
      movieCount: movieCount ?? this.movieCount,
      limit: limit ?? this.limit,
      pageNumber: pageNumber ?? this.pageNumber,
      movies: movies ?? this.movies,
    );
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


class MoviesExploreEntity extends MoviesEntity{
  MoviesExploreEntity({
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

  MoviesExploreEntity.fromJson(dynamic json) {
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
        torrents?.add(TorrentsExploreEntity.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

}

class TorrentsExploreEntity extends TorrentsEntity {
  TorrentsExploreEntity({
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

  TorrentsExploreEntity.fromJson(dynamic json) {
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