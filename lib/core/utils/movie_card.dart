import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import 'custom_image.dart';

class MoviePosterCard extends StatelessWidget {
  final MoviesEntity movie;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const MoviePosterCard({
    super.key,
    required this.movie,
    double? width,
    double? height,
    this.onPressed,
  })  : width = width ?? 198,
        height = height ?? 279;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.of(context).pushNamed(
            RouteNames.movieDetails,
            arguments: movie,
          );
        }
      },
      child: Container(
        width: width.sp,
        height: height.sp,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            // Poster Image
            CustomImage(
              movie.mediumCoverImage ?? '',
              width: width.sp,
              height: height.sp,
              isNetwork: true,
              fit: BoxFit.cover,
              radius: 12.r,
              isShadow: false,
            ),

            // Rating Badge
            Positioned(
              top: 8.sp,
              left: 8.sp,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBgColor.withAlpha(181),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Text(
                      movie.rating?.toString() ?? '',
                      style: TextStyle(
                        color: AppColors.primaryYellowColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 4.sp),
                    SvgPicture.asset(
                      AppAssets.star,
                      color: AppColors.primaryYellowColor,
                      width: 15.sp,
                      height: 15.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
