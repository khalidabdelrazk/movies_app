import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/browse/ui/browse_page.dart';
import '../../presentation/home/ui/home_page.dart';
import '../../presentation/profile/ui/profile_page.dart';
import '../../presentation/search/ui/cubit/search_view_model.dart';
import '../../presentation/search/ui/search_page.dart';
import '../assets/app_assets.dart';
import '../di/di.dart';

List rootBody = [
  {
    "icon": AppAssets.home,
    "page": HomePage(),
  },
  {
    "icon": AppAssets.search,
    "page": BlocProvider(
      create: (_) => getIt<SearchViewModel>(),
      child: SearchPage(),
    ),
  },
  {
    "icon": AppAssets.browse,
    "page": BrowsePage(),
  },
  {
    "icon": AppAssets.profile,
    "page": ProfilePage(),
  },
];

List<String> genre = [
  'Action',
  'Adventure',
  'Animation',
  'Biography',
  'Comedy',
  'Crime',
  'Documentary',
  'Drama',
  'Family',
  'Fantasy',
  'Film-Noir',
  'Game-Show',
  'History',
  'Horror',
  'Music',
  'Musical',
  'Mystery',
  'News',
  'Reality-TV',
  'Romance',
  'Sci-Fi',
  'Short',
  'Sport',
  'Talk-Show',
  'Thriller',
  'War',
  'Western',
];
