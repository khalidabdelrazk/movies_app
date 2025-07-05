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
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.onBoarding6)),
        ),
        child: ListView(
          children: [
            SizedBox(
              width: 267.w,
              height: 93.h,
              child: Image.asset(AppAssets.available),
            ),
            SizedBox(
              height: 360,
              width: double.infinity,
              child: MostPopularSlider(),
            ),
            SizedBox(
              width: 267.w,
              height: 93.h,
              child: Image.asset(AppAssets.watchNow),
            ),
            Column(
              children: List.generate(
                genre.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(top: 8.h,left: 16.w),
                  child: CategoryMovieSlider(genre: genre[index],),
                ),
              ),
            ),
            SizedBox(height: 70.h,),
          ],
        ),
      ),
    );
  }
}
