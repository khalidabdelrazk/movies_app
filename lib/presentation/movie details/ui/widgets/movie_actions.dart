import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onPressed: () async {
              final url = movieDetailsResponseEntity.data?.movie?.url;
              if (url != null && await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Could not open movie URL')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 14.h),
            ),
            child: Text(
              'See more',
              style: TextStyle(
                color: AppColors.light,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RatingContainer(
                child: RatingItem(
                  imagePath: AppAssets.love,
                  value: movieDetailsResponseEntity.data?.movie?.likeCount.toString() ?? '90',
                  color: AppColors.primaryYellowColor,
                ),
              ),
              _RatingContainer(
                child: RatingItem(
                  imagePath: AppAssets.timer,
                  value: movieDetailsResponseEntity.data?.movie?.runtime.toString() ?? '90',
                  color: AppColors.primaryYellowColor,
                ),
              ),
              _RatingContainer(
                child: RatingItem(
                  imagePath: AppAssets.star,
                  value: movieDetailsResponseEntity.data?.movie?.rating?.toString() ?? "0.0",
                  color: AppColors.primaryYellowColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingContainer extends StatelessWidget {
  final Widget child;
  const _RatingContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
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
