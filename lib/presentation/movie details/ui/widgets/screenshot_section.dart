import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class ScreenshotsSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const ScreenshotsSection({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    final screenshots = [
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage1,
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage2,
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage3,
    ];

    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: screenshots.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final imageUrl = screenshots[index] ?? '';

          return ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              imageUrl,
              width: 280.w,
              height: 180.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey, width: 280.w, height: 180.h),
            ),
          );
        },
      ),
    );
  }
}
