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
      pinned: true,
      stretch: true,
      expandedHeight: 500.h,
      backgroundColor: AppColors.scaffoldBgColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.data?.movie?.largeCoverImage ?? '',
              width: double.infinity,
              height: 500.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
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
            // Center Play Button
            Center(
              child: CircleAvatar(
                radius: 36.r,
                backgroundColor: AppColors.primaryYellowColor,
                child: Icon(
                  Icons.play_arrow,
                  color: AppColors.scaffoldBgColor,
                  size: 40.r,
                ),
              ),
            ),
            // Title & Year at the bottom
            Positioned(
              bottom: 32.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    movie.data?.movie?.titleEnglish ?? 'Unknown Title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.light,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    movie.data?.movie?.year?.toString() ?? 'Unknown Year',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.light, size: 24.r),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: IconButton(
            icon: Icon(Icons.bookmark_outline,
                color: AppColors.light, size: 24.r),
            onPressed: () {
              // Handle bookmark action
            },
          ),
        ),
      ],
    );
  }
}
