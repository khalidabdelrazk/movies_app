import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/constants/constants.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/utils/network_error_widget.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_states.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_view_model.dart';
import 'package:movies/presentation/movie%20details/ui/widgets/genre_chips.dart';
import 'package:movies/presentation/movie%20details/ui/widgets/movie_details_app_bar.dart';
import 'package:movies/presentation/movie%20details/ui/widgets/screenshot_section.dart';
import 'package:movies/presentation/movie%20details/ui/widgets/similar_movie_section.dart';
import 'package:movies/presentation/profile/ui/cubit/profile_page_view_model.dart';
import 'widgets/movie_actions.dart';
import 'widgets/section_title.dart';
import 'widgets/summary_section.dart';
import 'widgets/cast_section.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetails> {
  late MovieDetailsResponseEntity movie;
  final MovieDetailsViewModel movieDetailsViewModel =
      getIt<MovieDetailsViewModel>();
  final ProfilePageViewModel profilePageViewModel =
      getIt<ProfilePageViewModel>();
  bool isFavourite = false;
  MoviesEntity? arg;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arg ??= ModalRoute.of(context)?.settings.arguments as MoviesEntity?;

    if (arg != null) {
      movieDetailsViewModel.getMovieDetails(
          imdbId: arg?.imdbCode?.toString() ?? "0",
          isFavourite: isFavourite,
          movieId: arg?.id ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: movieDetailsViewModel,
      builder: (context, state) {
        if (state is MovieDetailsErrorState) {
          return NetworkErrorWidget(
              onTap: () async => movieDetailsViewModel.getMovieDetails(
                  imdbId: arg?.imdbCode?.toString() ?? "0",
                  isFavourite: isFavourite,
                  movieId: arg?.id ?? 0),
              errorMsg: state.errMsg ?? "An error occurred",
              large: true);
        } else if (state is MovieDetailsSuccessState) {
          movie = state.movieDetailsResponseEntity;
          return Scaffold(
            backgroundColor: AppColors.black,
            body: CustomScrollView(
              slivers: [
                MovieDetailsAppBar(
                  movie: movie,
                  isFav: state.movieDetailsResponseEntity.isFavourite!,
                  onFavToggle: () async {
                    setState(() {
                      state.movieDetailsResponseEntity.isFavourite =
                          !state.movieDetailsResponseEntity.isFavourite!;
                      if (state.movieDetailsResponseEntity.isFavourite!) {
                        state.movieDetailsResponseEntity.data?.movie
                            ?.likeCount = (state.movieDetailsResponseEntity.data
                                    ?.movie?.likeCount ??
                                0) +
                            1;
                      } else {
                        state.movieDetailsResponseEntity.data?.movie
                            ?.likeCount = (state.movieDetailsResponseEntity.data
                                    ?.movie?.likeCount ??
                                0) -
                            1;
                      }
                    });
                    await profilePageViewModel.getWishList();
                    await movieDetailsViewModel.addToFav(
                        movie: state.movieDetailsResponseEntity,
                        isFavourite:
                            state.movieDetailsResponseEntity.isFavourite!);
                    // profilePageViewModel.iInititialized = false;
                  },
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // MovieHeader(movie: movie),
                      // SizedBox(height: 16.h),
                      MovieActions(movieDetailsResponseEntity: movie),
                      SizedBox(height: 24.h),
                      SectionTitle(title: 'Screenshots'),
                      SizedBox(height: 16.h),
                      ScreenshotsSection(movieDetailsResponseEntity: movie),
                      SizedBox(height: 24.h),
                      SectionTitle(title: 'Similar'),
                      SizedBox(height: 16.h),
                      SimilarMovieSection(
                        imdbId: movie.data?.movie?.id.toString(),
                      ),
                      SizedBox(height: 24.h),
                      SectionTitle(title: 'Summary'),
                      SizedBox(height: 2.h),
                      SummarySection(
                          summary: movie.data?.movie?.summary ?? summary),
                      SizedBox(height: 24.h),
                      SectionTitle(title: 'Cast'),
                      SizedBox(height: 16.h),
                      CastSection(movieDetailsResponseEntity: movie),
                      SizedBox(height: 24.h),
                      SectionTitle(title: "Genre"),
                      SizedBox(height: 16.h),
                      GenresChips(genres: arg!.genres ?? ["Action"]),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
