import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/presentation/browse/ui/cubit/explore_states.dart';
import 'package:movies/presentation/browse/ui/cubit/explore_view_model.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/movie_card.dart';
import '../../../core/utils/network_error_widget.dart'; // ✅ Make sure it's imported

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final exploreViewModel = getIt<ExploreViewModel>();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _chipsScrollController = ScrollController();
  late List<GlobalKey> _chipKeys;

  String selectedGenre = genre[0];

  @override
  void initState() {
    super.initState();
    _chipKeys = List.generate(genre.length, (_) => GlobalKey());
    exploreViewModel.fetchInitialMovies(selectedGenre);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        !exploreViewModel.isLoadingMore) {
      exploreViewModel.fetchMoreMovies();
    }
  }

  void _scrollToSelectedChip(int index) {
    final keyContext = _chipKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
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
                controller: _chipsScrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: genre.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final item = genre[index];
                  final isSelected = item == selectedGenre;

                  return GestureDetector(
                    key: _chipKeys[index],
                    onTap: () {
                      setState(() {
                        selectedGenre = item;
                      });
                      exploreViewModel.fetchInitialMovies(item);
                      _scrollToSelectedChip(index);
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
                              ? AppStyles.darkSemiBold20.copyWith(fontSize: 14.sp)
                              : AppStyles.lightRegular16.copyWith(fontSize: 14.sp),
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
                      onTap: () async => exploreViewModel.fetchInitialMovies(selectedGenre),
                    );
                  } else if (state is ExploreSuccessState) {
                    final movies = state.exploreResponseEntity.data?.movies ?? [];

                    return GridView.builder(
                      controller: _scrollController,
                      itemCount: movies.length +
                          (exploreViewModel.isLoadingMore ? 1 : 0),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        if (index < movies.length) {
                          return MoviePosterCard(movie: movies[index]);
                        } else {
                          return Center(
                            child: SizedBox(
                              width: 24.sp,
                              height: 24.sp,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primaryYellowColor,
                              ),
                            ),
                          );
                        }
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
