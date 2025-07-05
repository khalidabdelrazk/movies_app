// movie_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/utils/network_error_widget.dart';

import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_states.dart';
import 'package:movies/presentation/movie%20details/ui/cubit/movie_details_view_model.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetails> {
  late MovieDetailsResponseEntity movie;
  final MovieDetailsViewModel movieDetailsViewModel =
      getIt<MovieDetailsViewModel>();
  @override
  void initState() {
    super.initState();
    movieDetailsViewModel.getMovieDetails(imdbId: "tt32135407");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: movieDetailsViewModel,
      builder: (context, state) {
        if (state is MovieDetailsErrorState) {
          return NetworkErrorWidget(
              errorMsg: state.errMsg ?? " hii", large: true);
        } else if (state is MovieDetailsSuccessState) {
          movie = state.movieDetailsResponseEntity;
          return Scaffold(
            backgroundColor: AppColors.scaffoldBgColor,
            body: CustomScrollView(
              slivers: [
                _AppBar(movie: movie),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _MovieHeader(movie: movie),
                      SizedBox(height: 16.h),
                      MovieActions(
                        movieDetailsResponseEntity: movie,
                      ),
                      SizedBox(height: 24.h),
                      _SectionTitle(title: 'Screen shots'),
                      SizedBox(height: 16.h),
                      ScreenshotsSection(
                        movieDetailsResponseEntity: movie,
                      ),
                      SizedBox(height: 24.h),
                      _SectionTitle(title: 'Similar'),
                      SizedBox(height: 16.h),
                      SimilarMoviesSection(
                        movieDetailsResponseEntity: movie,
                      ),
                      SizedBox(height: 24.h),
                      _SectionTitle(title: 'Summary'),
                      SizedBox(height: 16.h),
                      _SummarySection(
                          summary: movie.data?.movie?.summary ?? " dd"),
                      SizedBox(height: 24.h),
                      _SectionTitle(title: 'Cast'),
                      SizedBox(height: 16.h),
                      CastSection(movieDetailsResponseEntity: movie,),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  final MovieDetailsResponseEntity movie;

  const _AppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280.h,
      backgroundColor: AppColors.scaffoldBgColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.data?.movie?.backgroundImage ?? '',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.scaffoldBgColor,
                  ],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.light, size: 24.r),
        onPressed: () {
          // Handle back button press
        },
      ),
      actions: [
        IconButton(
          icon:
              Icon(Icons.bookmark_outline, color: AppColors.light, size: 24.r),
          onPressed: () {
            // Handle bookmark button press
          },
        ),
      ],
    );
  }
}

class _MovieHeader extends StatelessWidget {
  final MovieDetailsResponseEntity movie;

  const _MovieHeader({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundColor: AppColors.primaryYellowColor,
            child: Icon(
              Icons.play_arrow,
              size: 40.r,
              color: AppColors.scaffoldBgColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            movie.data?.movie?.titleEnglish ?? 'N/A',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.light,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            (movie.data?.movie?.year != null)
                ? '${movie.data?.movie?.year}'
                : 'N/A',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieActions extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const MovieActions({super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle watch now
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              minimumSize: Size(double.infinity, 0), // Make button full width
            ),
            child: Text(
              'Watch now',
              style: TextStyle(
                color: AppColors.light,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RatingItem(
                icon: Icons.thumb_up,
                value: '15',
                color: AppColors.primaryYellowColor,
              ),
              _RatingItem(
                imagePath:
                    'assets/images/imdb_logo.png', // You'll need to add an IMDb logo asset
                value: '90',
                color: AppColors.primaryYellowColor,
              ),
              _RatingItem(
                icon: Icons.star,
                value:
                    movieDetailsResponseEntity.data?.movie?.rating.toString() ??
                        "00",
                color: AppColors.primaryYellowColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String value;
  final Color color;

  const _RatingItem(
      {this.icon, this.imagePath, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null)
          Icon(
            icon,
            color: color,
            size: 24.r,
          )
        else if (imagePath != null)
          Image.asset(
            imagePath!,
            width: 24.w,
            height: 24.h,
            color:
                color, // Apply color if needed, or remove if the asset has its own color
          ),
        SizedBox(height: 4.h),
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

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.light,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ScreenshotsSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const ScreenshotsSection(
      {super.key, required this.movieDetailsResponseEntity});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                movieDetailsResponseEntity
                        .data?.movie?.mediumScreenshotImage1 ??
                    "",
                width: 150.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class SimilarMoviesSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const SimilarMoviesSection(
      {super.key, required this.movieDetailsResponseEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    movieDetailsResponseEntity.data?.movie?.backgroundImage ??
                        " ",
                    width: 100.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    movieDetailsResponseEntity.data?.movie?.title ?? ' ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.light,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final String summary;

  const _SummarySection({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        summary,
        style: TextStyle(
          color: AppColors.gray,
          fontSize: 14.sp,
          height: 1.5,
        ),
      ),
    );
  }
}

class CastSection extends StatelessWidget {
  final MovieDetailsResponseEntity movieDetailsResponseEntity;

  const CastSection({super.key, required this.movieDetailsResponseEntity});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h, // Adjust height as needed for cast items
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieDetailsResponseEntity.data?.movie?.cast?.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundImage: NetworkImage(movieDetailsResponseEntity.data?.movie?.backgroundImage ?? " "),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    movieDetailsResponseEntity.data?.movie?.cast?[index].name ?? " name",
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
                    movieDetailsResponseEntity.data?.movie?.cast?[index].characterName ?? " ch Name",
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
            ),
          );
        },
      ),
    );
  }
}
