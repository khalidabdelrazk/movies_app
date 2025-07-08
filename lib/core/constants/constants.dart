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

String summary =
    "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346";