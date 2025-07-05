import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/core/theme/app_theme.dart';
import 'package:movies/generated/codegen_loader.g.dart';
import 'package:movies/presentation/root/root.dart';
import 'package:path_provider/path_provider.dart';
import 'core/di/di.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/shared_pref_services.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await SharedPrefService.instance.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar')
      ], //startLocale: Locale('en'),
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routes: Routes.myAppRoutes,
          initialRoute: isFirstOpened
              ? (isLoggedIn ? RouteNames.root : RouteNames.login)
              : RouteNames.onboarding,
          //
        );
      },
      child: Root(),
    );
  }

  bool get isLoggedIn => SharedPrefService.instance.getToken() != null;
  bool get isFirstOpened => SharedPrefService.instance.isFirsTime() ?? false;
}


/*
class MoviesResponseEntity {
  MoviesResponseEntity({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MoviesResponseEntity.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? DataEntity.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaEntity.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  DataEntity? data;
  MetaEntity? meta;
}

class MetaEntity {
  MetaEntity({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  MetaEntity.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
  num? serverTime;
  String? serverTimezone;
  num? apiVersion;
  String? executionTime;
}

class DataEntity {
  DataEntity({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  DataEntity.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesEntity.fromJson(v));
      });
    }
  }
  num? movieCount;
  num? limit;
  num? pageNumber;
  List<MoviesEntity>? movies;
}

class MoviesEntity {
  MoviesEntity({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  MoviesEntity.fromJson(dynamic json) {
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
        torrents?.add(TorrentsEntity.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  num? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  num? year;
  num? rating;
  num? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<TorrentsEntity>? torrents;
  String? dateUploaded;
  num? dateUploadedUnix;
}

class TorrentsEntity {
  TorrentsEntity({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  TorrentsEntity.fromJson(dynamic json) {
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
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  num? seeds;
  num? peers;
  String? size;
  num? sizeBytes;
  String? dateUploaded;
  num? dateUploadedUnix;
}

 */