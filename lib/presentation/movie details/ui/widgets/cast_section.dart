import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class CastSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const CastSection({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    final castList = movieDetailsResponseEntity.data?.movie?.cast ?? [];

    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: castList.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final cast = castList[index];

          /// Generate image URL using IMDb code
          final imageUrl = cast.imdbCode != null
              ? "https://img.yts.mx/assets/images/actors/${cast.imdbCode}.jpg"
              : "https://via.placeholder.com/150"; // fallback

          return Column(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey[800],
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 80.w,
                child: Text(
                  cast.name ?? "Unknown",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.light,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: 80.w,
                child: Text(
                  cast.characterName ?? "Character",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 10.sp,
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
