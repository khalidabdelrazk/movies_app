import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
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
          final movie = similarMovies[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  movie?.mediumCoverImage ?? '',
                  width: 120.w,
                  height: 170.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey,
                    width: 120.w,
                    height: 170.h,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              SizedBox(
                width: 120.w,
                child: Text(
                  movie?.title ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.light,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
