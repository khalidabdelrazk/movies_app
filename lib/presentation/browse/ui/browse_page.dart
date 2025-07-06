import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/presentation/home/Domain/Entity/movies_response_entity.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/movie_card.dart';


class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  String selectedGenre = genre[0];
  late ScrollController _scrollController;

  // Keys for every chip to ensure visibility
  late List<GlobalKey> _chipKeys;

  final List<MoviesEntity> dummyMovies = List.generate(
    6,
        (index) => MoviesEntity(
      title: "Movie $index",
      mediumCoverImage: "https://i.imgur.com/8UG2N6Q.jpg",
      rating: 7.7,
      imdbCode: "tt123456$index",
    ),
  );

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _chipKeys = List.generate(genre.length, (_) => GlobalKey());
  }

  void _scrollToSelectedChip(int index) {
    final keyContext = _chipKeys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5, // Center the selected chip
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Genres Chips
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                controller: _scrollController,
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
                      setState(() => selectedGenre = item);
                      _scrollToSelectedChip(index);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: GridView.builder(
                  itemCount: dummyMovies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return MoviePosterCard(movie: dummyMovies[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
