import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/presentation/browse/ui/cubit/explore_states.dart';
import 'package:movies/presentation/browse/ui/cubit/explore_view_model.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/movie_card.dart';
import '../../../core/utils/network_error_widget.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final exploreViewModel = getIt<ExploreViewModel>();

  @override
  void initState() {
    super.initState();
    exploreViewModel.chipKeys = List.generate(genre.length, (_) => GlobalKey());
    exploreViewModel.fetchInitialMovies(exploreViewModel.selectedGenre);
    exploreViewModel.scrollController.addListener(exploreViewModel.onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Genre Chips
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                controller: exploreViewModel.chipsScrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: genre.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final item = genre[index];
                  final isSelected = item == exploreViewModel.selectedGenre;

                  return GestureDetector(
                    key: exploreViewModel.chipKeys[index],
                    onTap: () {
                      setState(() {
                        exploreViewModel.selectedGenre = item;
                      });
                      exploreViewModel.fetchInitialMovies(item);
                      exploreViewModel.scrollToSelectedChip(index);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryYellowColor
                            : AppColors.darkGray,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: isSelected
                              ? AppStyles.darkSemiBold20
                                  .copyWith(fontSize: 14.sp)
                              : AppStyles.lightRegular16
                                  .copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),

            // Movie Grid
            Expanded(
              child: BlocBuilder<ExploreViewModel, ExploreStates>(
                bloc: exploreViewModel,
                builder: (context, state) {
                  if (state is ExploreLoadingState &&
                      exploreViewModel.currentPage == 1) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExploreErrorState) {
                    return NetworkErrorWidget(
                      errorMsg: state.errMessage,
                      large: true,
                      onTap: () async =>
                          exploreViewModel.fetchInitialMovies(exploreViewModel.selectedGenre),
                    );
                  } else if (state is ExploreSuccessState) {
                    final movies =
                        state.exploreResponseEntity.data?.movies ?? [];

                    return GridView.builder(
                      controller: exploreViewModel.scrollController,
                      itemCount: movies.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        return MoviePosterCard(
                          movie: movies[index],
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.movieDetails);
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
