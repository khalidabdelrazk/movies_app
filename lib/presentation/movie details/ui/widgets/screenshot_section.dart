import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/utils/custom_image.dart';
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
      children:  List.generate(
      screenshots.length,
          (index) {
        final imageUrl = screenshots[index];
        final isValidUrl = imageUrl != null &&
            imageUrl.startsWith('http') &&
            Uri.tryParse(imageUrl)?.hasAbsolutePath == true;

        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: isValidUrl
                ? CustomImage(
              imageUrl,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
              radius: 0,
            )
                : Container(
              width: double.infinity,
              height: 167.h,
              color: Colors.grey,
              child: Center(
                child: Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}
