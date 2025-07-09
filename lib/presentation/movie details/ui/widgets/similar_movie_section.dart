import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/utils/movie_card.dart';
import 'package:movies/core/utils/network_error_widget.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_states.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_view_model.dart';

class SimilarMovieSection extends StatefulWidget {
  final String? imdbId;
  const SimilarMovieSection({super.key, this.imdbId});

  @override
  State<SimilarMovieSection> createState() => _SimilarMovieSectionState();
}

class _SimilarMovieSectionState extends State<SimilarMovieSection> {
  final MovieDetailsViewModel movieDetailsViewModel = getIt<MovieDetailsViewModel>();
  @override
  void initState() {
    super.initState();
    movieDetailsViewModel.getMovieSuggestion(imdbId: widget.imdbId ?? "0");
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: movieDetailsViewModel,
      builder: (context, state) {
        if (state is MovieSuggestionErrorState) {
          return NetworkErrorWidget(
            onTap: () async =>     movieDetailsViewModel.getMovieSuggestion(imdbId: widget.imdbId ?? "0"),
              errorMsg: state.errMsg ?? "An error occurred", large: false);
        } else if (state is MovieSuggestionSuccessState) {
          return SizedBox(
            height: 270.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount:
                  state.movieSuggestionResponseEntity.data?.movies?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return MoviePosterCard(
                    movie: state
                        .movieSuggestionResponseEntity.data!.movies![index],height: 270.h,);
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

/*
// Fake similar movies data (copy the same movie multiple times for demo)
    final similarMovies = List.generate(
      6,
          (index) => movieDetailsResponseEntity.data?.movie,
    );

    return SizedBox(
      height: 220.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: similarMovies.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return MoviePosterCard(movie: movieDetailsResponseEntity.data!.movie! );
        },
      ),
    );
 */
