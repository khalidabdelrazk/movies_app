import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/presentation/profile/ui/widgets/history_list.dart';
import 'package:movies/presentation/profile/ui/widgets/profile_widget.dart';
import 'package:movies/presentation/profile/ui/widgets/watch_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGray,
      body: Column(
        children: [
          const ProfileWidget(),
          Row(
            children: [
              _buildTabItem("Wish List", AppAssets.watchlist, 1),
              _buildTabItem("History", AppAssets.folder, 2),
            ],
          ),
          Expanded(
            child: selectedIndex == 1
                ? Container(
                    color: AppColors.scaffoldBgColor,
                    child: WatchList(key: UniqueKey())) // <-- Force rebuild
                : const HistoryList(),
          ),
        ],
      ),
    );
  }

  Expanded _buildTabItem(String title, String asset, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          children: [
            SizedBox(
              width: 40.h,
              height: 40.h,
              child: SvgPicture.asset(asset),
            ),
            SizedBox(height: 8.h),
            Text(title, style: AppStyles.lightRegular20),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              height: 3.h,
              width: double.infinity,
              color: selectedIndex == index
                  ? AppColors.primaryYellowColor
                  : AppColors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
