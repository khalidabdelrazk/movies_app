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
  late ScrollController _chipsScrollController;
  late List<GlobalKey> _chipKeys;

  List<MoviesEntity> movies = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  final int pageSize = 6;

  @override
  void initState() {
    super.initState();
    _chipsScrollController = ScrollController();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _chipKeys = List.generate(genre.length, (_) => GlobalKey());
    _loadInitialMovies();
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

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore) {
      _loadMoreMovies();
    }
  }

  void _loadInitialMovies() {
    setState(() {
      movies = List.generate(
        pageSize,
            (index) => MoviesEntity(
          title: "Movie $index",
          mediumCoverImage: "https://i.imgur.com/8UG2N6Q.jpg",
          rating: 7.7,
          imdbCode: "tt123456$index",
        ),
      );
    });
  }

  Future<void> _loadMoreMovies() async {
    setState(() => isLoadingMore = true);

    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

    final newMovies = List.generate(
      pageSize,
          (index) => MoviesEntity(
        title: "Movie ${movies.length + index}",
        mediumCoverImage: "https://i.imgur.com/8UG2N6Q.jpg",
        rating: 7.7,
        imdbCode: "tt123456${movies.length + index}",
      ),
    );

    setState(() {
      movies.addAll(newMovies);
      currentPage++;
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chipsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        currentPage = 1;
                        movies.clear();
                        _loadInitialMovies(); // reload for new genre
                      });
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
                  controller: _scrollController,
                  itemCount: movies.length + (isLoadingMore ? 2 : 0),
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
                          width: 28.sp,
                          height: 28.sp,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryYellowColor,
                          ),
                        ),
                      );
                    }
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
