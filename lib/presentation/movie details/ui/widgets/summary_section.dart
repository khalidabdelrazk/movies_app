import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';

class SummarySection extends StatelessWidget {
  final String summary;

  const SummarySection({super.key, required this.summary});

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
