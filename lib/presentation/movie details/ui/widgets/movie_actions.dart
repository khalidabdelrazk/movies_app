import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class MovieActions extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const MovieActions({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle watch now
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            child: Text(
              'Watch',
              style: TextStyle(
                color: AppColors.light,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RatingItem(
                imagePath: AppAssets.love,
                value: '15',
                color: AppColors.primaryYellowColor,
              ),
              RatingItem(
                imagePath: AppAssets.timer,
                value: '90',
                color: AppColors.primaryYellowColor,
              ),
              RatingItem(
                imagePath: AppAssets.star,
                value: movieDetailsResponseEntity.data?.movie?.rating
                    ?.toString() ??
                    "0.0",
                color: AppColors.primaryYellowColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String value;
  final Color color;

  const RatingItem({
    super.key,
    this.icon,
    this.imagePath,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          Icon(icon, color: color, size: 26.r)
        else if (imagePath != null)
          SvgPicture.asset(
            imagePath!,
            width: 28.w,
            height: 28.h,
            fit: BoxFit.contain,
          ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            color: AppColors.light,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
