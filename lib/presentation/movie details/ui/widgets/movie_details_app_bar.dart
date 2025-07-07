import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/presentation/movie%20details/Domain/Entity/movie_details_response_entity.dart';

class MovieDetailsAppBar extends StatefulWidget {
  final MovieDetailsResponseEntity movie;

  final bool isFav;
  final VoidCallback onFavToggle;

  const MovieDetailsAppBar({
    super.key,
    required this.movie,
    required this.isFav,
    required this.onFavToggle,
  });
  @override
  State<MovieDetailsAppBar> createState() => _MovieDetailsAppBarState();
}

class _MovieDetailsAppBarState extends State<MovieDetailsAppBar> {
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false, // ❌ not pinned
      stretch: true,
      expandedHeight: 500.h,
      backgroundColor: AppColors.scaffoldBgColor,
      elevation: 0,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.axis == Axis.vertical) {
            final shouldCollapse =
                notification.metrics.pixels > (500.h - kToolbarHeight - 30);
            if (shouldCollapse != isCollapsed) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    isCollapsed = shouldCollapse;
                  });
                }
              });
            }
          }
          return false;
        },
        child: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                widget.movie.data?.movie?.largeCoverImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),

              // Gradient Overlay
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

              // Top Right Favorite Button
              Positioned(
                top: 40.h,
                right: 20.w,
                child: GestureDetector(
                  onTap: widget.onFavToggle,
                  child: Icon(
                    widget.isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.primaryYellowColor,
                    size: 28.r,
                  ),
                ),
              ),

              // Center Play Button
              if (!isCollapsed)
                Center(
                  child: CircleAvatar(
                    radius: 36.r,
                    backgroundColor: AppColors.primaryYellowColor,
                    child: Icon(
                      Icons.play_arrow,
                      color: AppColors.scaffoldBgColor,
                      size: 40.r,
                    ),
                  ),
                ),

              // Title + Year
              if (!isCollapsed)
                Positioned(
                  bottom: 32.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        widget.movie.data?.movie?.title ?? 'Unknown Title',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.light,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.movie.data?.movie?.year?.toString() ??
                            'Unknown Year',
                        style: TextStyle(
                          color: AppColors.gray,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
