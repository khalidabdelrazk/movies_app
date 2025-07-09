import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/utils/movie_card.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/network_error_widget.dart';
import '../cubit/home_states.dart';
import '../cubit/home_view_model.dart';

class MostPopularSlider extends StatefulWidget {
  const MostPopularSlider({
    super.key,
  });

  @override
  State<MostPopularSlider> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopularSlider> {
  final HomeViewModel homeViewModel = getIt<HomeViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.getMostPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: homeViewModel,
        builder: (context, state) {
          if (state is MostPopularErrorState) {
            return NetworkErrorWidget(
              errorMsg: state.message,
              large: false,
              onTap: () async => homeViewModel.getMostPopularMovies,
            );
          } else if (state is MostPopularSuccessState) {
            List<MoviesEntity> movies =
                state.moviesResponseEntity.data?.movies ?? [];
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 351.h,
                enlargeCenterPage: true,
                viewportFraction: 0.65,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index, pageIndex) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: MoviePosterCard(
                    movie: movies[index],
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
