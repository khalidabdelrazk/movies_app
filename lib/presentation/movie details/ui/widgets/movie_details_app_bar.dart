import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class MovieDetailsAppBar extends StatelessWidget {
  final MovieDetailsResponseEntity movie;

  const MovieDetailsAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      foregroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      expandedHeight: 500.h,
      backgroundColor: AppColors.scaffoldBgColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.data?.movie?.largeCoverImage ?? '',
              fit: BoxFit.cover,
              height: 500.h,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.scaffoldBgColor,
                  ],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.light, size: 24.r),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_outline,
              color: AppColors.light, size: 24.r),
          onPressed: () {
            // Handle bookmark
          },
        ),
      ],
    );
  }
}
