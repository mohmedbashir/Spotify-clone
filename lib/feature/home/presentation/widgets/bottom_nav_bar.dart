import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/assets/icons.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/home/presentation/bloc/nav/nav_cubit.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/theme_cubit/theme_cubit.dart';
// import 'package:get/route_manager.dart';
// import 'package:spotify/core/helpers/color_adjustment.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, currentIndex) {
        return SizedBox(
          height: 100.h,
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              // print(mode.toString())
              return BottomNavigationBar(
                backgroundColor: mode == ThemeMode.dark
                    ? AppColors.AppTabBarDarkModeColor
                    : Colors.white,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                elevation: 1,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (newIndex) =>
                    context.read<NavBarCubit>().changeNavBarIndex(newIndex),
                items: [
                  _homeTab(),
                  _favoritesTab(),
                  _profileTab(),
                ],
              );
            },
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _profileTab() {
    return BottomNavigationBarItem(
        activeIcon: Column(
          children: [
            Image.asset(AppIcons.filledProfileTab, height: 25.h),
            verticalSpaceing(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  height: 4.h, width: 20.w, color: AppColors.secondary),
            ),
          ],
        ),
        label: "",
        icon: Image.asset(AppIcons.profileTab, height: 25.h));
  }

  BottomNavigationBarItem _favoritesTab() {
    return BottomNavigationBarItem(
        activeIcon: Column(
          children: [
            Image.asset(AppIcons.filledFavoritesTab, height: 25.h),
            verticalSpaceing(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  height: 4.h, width: 20.w, color: AppColors.secondary),
            ),
          ],
        ),
        label: "",
        icon: Image.asset(AppIcons.favoritesTab, height: 25.h));
  }

  BottomNavigationBarItem _homeTab() {
    return BottomNavigationBarItem(
        activeIcon: Column(
          children: [
            Image.asset(
              AppIcons.filledHomeTab,
              height: 25.h,
            ),
            verticalSpaceing(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  height: 4.h, width: 20.w, color: AppColors.secondary),
            ),
          ],
        ),
        label: "",
        icon: Image.asset(AppIcons.homeTab, height: 25.h));
  }
}
