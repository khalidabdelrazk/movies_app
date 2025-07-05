import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/utils/movie_card.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class SimilarMoviesSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const SimilarMoviesSection({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
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
  }
}
