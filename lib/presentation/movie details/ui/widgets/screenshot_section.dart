import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class ScreenshotsSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const ScreenshotsSection(
      {super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    final screenshots = [
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage1,
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage2,
      movieDetailsResponseEntity.data?.movie?.mediumScreenshotImage3,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        3,
        (index) {
          final imageUrl = screenshots[index] ?? '';
          return Padding(
            padding: EdgeInsets.only(bottom:  8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                height: 167.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey, width: 280.w, height: 180.h),
              ),
            ),
          );
        },
      ),
    );
  }
}
