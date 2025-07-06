import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/presentation/home/ui/widgets/category_movie_slider.dart';
import 'package:movies/presentation/home/ui/widgets/most_popular_slider.dart';
import '../../../core/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.onBoarding6),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: 267.w,
                    height: 93.h,
                    child: Image.asset(AppAssets.available),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 360.h,
                    child: const MostPopularSlider(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: 267.w,
                    height: 93.h,
                    child: Image.asset(AppAssets.watchNow),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.only(top: 8.h, left: 16.w),
                      child: CategoryMovieSlider(
                        key: ValueKey(genre[index]), // ✅ Unique key
                        genre: genre[index],
                      ),
                    ),
                    childCount: genre.length,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 70.h)),
              ],
            ),
          )),
    );
  }
}
