import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class CastSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const CastSection({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    final castList = movieDetailsResponseEntity.data?.movie?.cast ?? [];

    return Column(
      spacing: 10.h,
      children: List.generate(
        castList.length,
        (index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Image.asset(AppAssets.profiles[index],width: 70.w,height: 70.h,),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name :${castList[index].name ?? " "}",
                    style: AppStyles.lightRegular16.copyWith(fontSize: 12),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Character :${castList[index].characterName ?? " "}",
                    style: AppStyles.lightRegular16.copyWith(fontSize: 12),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
