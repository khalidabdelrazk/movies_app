import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/theme/app_colors.dart';

class SummarySection extends StatefulWidget {
  final String summary;

  const SummarySection({super.key, required this.summary});

  @override
  State<SummarySection> createState() => _SummarySectionState();
}

class _SummarySectionState extends State<SummarySection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.summary.split(' ');
    final isLong = words.length > 20;
    final displayText = isExpanded || !isLong
        ? widget.summary
        : '${words.sublist(0, 20).join(' ')}...';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayText,
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          if (isLong)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  isExpanded ? 'View Less' : 'Read More',
                  style: TextStyle(
                    color: AppColors.primaryYellowColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
