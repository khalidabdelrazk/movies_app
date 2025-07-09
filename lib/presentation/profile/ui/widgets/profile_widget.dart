import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/core/routes/route_names.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_styles.dart';
import 'package:movies/core/utils/custom_elvated_button.dart';
import 'package:movies/core/utils/network_error_widget.dart';
import 'package:movies/core/utils/shared_pref_services.dart';
import 'package:movies/presentation/profile/ui/cubit/profile_page_states.dart';
import 'package:movies/presentation/profile/ui/cubit/profile_page_view_model.dart';
import '../../../../core/utils/dialog_utils.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final ProfilePageViewModel viewModel = getIt<ProfilePageViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel,
      child: BlocBuilder<ProfilePageViewModel, ProfilePageStates>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const SafeArea(child: Center(child: CircularProgressIndicator()));
          } else if (state is ProfileErrorState) {
            return NetworkErrorWidget(
              errorMsg: state.failures.errorMessage,
              large: false,
              onTap: () => viewModel.getWishList(),
            );
          } else if (state is ProfileSuccessState) {
            final user = state.getProfileResponseEntity.data;
            return Container(
              width: double.infinity,
              height: 300.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(top: 40.h),
              color: AppColors.darkGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/gamer ${user?.avaterId ?? 1}.png",
                            width: 118.w,
                            height: 118.h,
                          ),
                          SizedBox(height: 15.h),
                          Text(user?.name ?? "User Name", style: AppStyles.lightBold20),
                        ],
                      ),
                      Column(
                        children: [
                          Text("10", style: AppStyles.lightBold24),
                          SizedBox(height: 15.h),
                          Text("Wish List", style: AppStyles.lightBold24),
                        ],
                      ),
                      Column(
                        children: [
                          Text("12", style: AppStyles.lightBold24),
                          SizedBox(height: 15.h),
                          Text("History", style: AppStyles.lightBold24),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomElvatedButton(
                          borderRadius: 12.r,
                          backgroundColor: AppColors.primaryYellowColor,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.profileUpdate,
                              arguments: {
                                'name': user!.name,
                                'email': user.email,
                                'avtarId': user.avaterId,
                                'viewModel': viewModel,
                              },
                            );
                          },
                          text: "Edit Profile",
                          textStyle: AppStyles.darkRegular20,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        flex: 1,
                        child: CustomElvatedButton(
                          borderRadius: 12.r,
                          backgroundColor: AppColors.red,
                          onPressed: () => showLogoutConfirmationDialog(context),
                          text: "Exit",
                          textStyle: AppStyles.darkRegular20,
                          svgIcon: AppAssets.exit,
                          iconSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    DialogUtils.showMessage(
      context: context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to logout?',
      posActionName: 'Yes',
      posAction: () async {
        await SharedPrefService.instance.clearToken();
        Navigator.pushReplacementNamed(context, RouteNames.login);
      },
      negActionName: 'Cancel',
    );
  }
}
