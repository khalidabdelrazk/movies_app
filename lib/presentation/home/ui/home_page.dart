import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.onBoarding6)),
        ),
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: Column(
            children: [
              SizedBox(
                width: 267.w,
                height: 93.h,
                child: Image.asset(AppAssets.available),
              ),
              SizedBox(
                height: 360,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
