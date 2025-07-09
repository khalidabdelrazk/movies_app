import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/utils/movie_card.dart';
import 'package:movies/generated/locale_keys.g.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import 'package:movies/presentation/home/ui/cubit/home_view_model.dart';

import '../../../../core/utils/network_error_widget.dart';
import '../cubit/home_states.dart';

class CategoryMovieSlider extends StatefulWidget {
  final String genre;
  const CategoryMovieSlider({super.key, required this.genre});

  @override
  State<CategoryMovieSlider> createState() => _CategoryMovieSliderState();
}

class _CategoryMovieSliderState extends State<CategoryMovieSlider> {
  HomeViewModel homeViewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    homeViewModel.getMostPopularMovies(genre: widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.genre,style: AppStyles.lightRegular20,),
              Spacer(),
              Text(LocaleKeys.general_ui_Browse_see_more_button.tr(),style: AppStyles.primaryRegular16),
              Icon(Icons.arrow_forward,color: AppColors.primaryYellowColor,size: 16,)
            ],
          ),
          SizedBox(height: 5.h,),
          BlocBuilder(
            bloc: homeViewModel,
            builder: (context, state) {
              if (state is MostPopularErrorState) {
                return NetworkErrorWidget(errorMsg: state.message, large: false,onTap: () async => homeViewModel.getMostPopularMovies,);
              } else if (state is MostPopularSuccessState) {
                List<MoviesEntity> movies = state.moviesResponseEntity.data?.movies ?? [];
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,

                    itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: MoviePosterCard(movie: movies[index],height: 300.h,width: 180.w,),
                        );
                      },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
