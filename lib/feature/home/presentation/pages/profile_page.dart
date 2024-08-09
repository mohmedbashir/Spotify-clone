import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/common/widgets/button.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/authentication/logic/usecases/sign_out.dart';
import 'package:spotify/feature/onBoarding/presentation/bloc/theme_cubit/theme_cubit.dart';
// import 'package:spotify/core/helpers/color_adjustment.dart';
// import 'package:get/route_manager.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:spotify/core/utils/assets/icons.dart';
// import 'package:spotify/core/common/widgets/app_bar.dart';
// import 'package:spotify/feature/home/presentation/widgets/home_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

User? user = FirebaseAuth.instance.currentUser;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return Scaffold(
          appBar: _appBar(mode),
          body: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(children: [
              _info(mode),
              verticalSpaceing(15),
              _changeTheme(mode, context),
              verticalSpaceing(15),
              _rateOurApp(mode),
              verticalSpaceing(15),
              Container(
                height: 70.h,
                padding: EdgeInsets.all(10.sp),
                decoration: _cardDecoration(mode),
                child: InkWell(
                  splashColor: Colors.amber,
                  onTap: () {
                    Get.bottomSheet(Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.sp)),
                      child: Column(
                        children: [
                          verticalSpaceing(20),
                          Text("Are you sure about signing out?",
                              style: AppFontStyles.bold18),
                          verticalSpaceing(10),
                          Row(
                            children: [
                              AppButton(
                                  width: 150.h,
                                  height: 50.w,
                                  label: "Yes",
                                  labelColor: Colors.black,
                                  background: Colors.white,
                                  onPressed: () {
                                    serviceLocator<SignOutUseCase>().call();
                                  }),
                              horizantalSpaceing(20),
                              AppButton(
                                  height: 50.h,
                                  width: 150.w,
                                  label: "No",
                                  background: AppColors.primary,
                                  onPressed: () {
                                    Get.back();
                                  }),
                            ],
                          ),
                          // verticalSpaceing(20),
                        ],
                      ),
                    ));
                  },
                  child: Ink(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: AppColors.primary,
                          size: 35.sp,
                        ),
                        horizantalSpaceing(10),
                        Text("Sign out", style: AppFontStyles.medium17),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  Container _rateOurApp(ThemeMode mode) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.all(10.sp),
      decoration: _cardDecoration(mode),
      child: Row(
        children: [
          Icon(
            Icons.star_outline_rounded,
            color: AppColors.primary,
            size: 35.sp,
          ),
          horizantalSpaceing(10),
          Text("Rate our app", style: AppFontStyles.medium17),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 20.sp)
        ],
      ),
    );
  }

  Container _changeTheme(ThemeMode mode, BuildContext context) {
    return Container(
      height: 70.h,
      padding: const EdgeInsets.all(10),
      decoration: _cardDecoration(mode),
      child: Row(
        children: [
          Icon(
            Icons.color_lens,
            color: AppColors.primary,
            size: 35.sp,
          ),
          horizantalSpaceing(10),
          Text(
            "Change Theme",
            style: AppFontStyles.medium17,
          ),
          Spacer(),
          _themeSwitch(mode, context)
        ],
      ),
    );
  }

  AppBar _appBar(ThemeMode mode) {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.black,
      elevation: 1.5,
      title: Text(
        "Profile",
        style: AppFontStyles.bold20,
      ),
      backgroundColor: mode == ThemeMode.dark
          ? AppColors.AppTabBarDarkModeColor
          : Colors.white,
    );
  }

  Switch _themeSwitch(ThemeMode mode, BuildContext context) {
    return Switch(
        thumbColor: WidgetStatePropertyAll(mode == ThemeMode.dark
            ? AppColors.AppTabBarDarkModeColor
            : Colors.white),
        thumbIcon: WidgetStatePropertyAll(mode == ThemeMode.dark
            ? const Icon(
                Icons.dark_mode,
                color: Colors.white,
              )
            : const Icon(Icons.light_mode_rounded)),
        activeColor: AppColors.grey,
        inactiveTrackColor: AppColors.grey,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        value: mode == ThemeMode.light,
        // activeThumbImage: AssetImage(AppIcons.lightModeIcon),
        // inactiveThumbImage: AssetImage(AppIcons.darkModeIcon),
        inactiveThumbColor: const Color.fromARGB(255, 210, 122, 122),
        onChanged: (mode) {
          context
              .read<ThemeCubit>()
              .toggleTheme(mode ? ThemeMode.light : ThemeMode.dark);
        });
  }

  Container _info(ThemeMode mode) {
    return Container(
      height: 90.h,
      decoration: _cardDecoration(mode),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_avatar(mode), horizantalSpaceing(10), _nameEmail()],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(ThemeMode mode) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: mode == ThemeMode.dark
            ? AppColors.AppTabBarDarkModeColor
            : Colors.white,
        boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(16, 0, 0, 0),
              spreadRadius: 0.sp,
              blurRadius: 4.sp,
              offset: Offset(1.5.sp, 1.5.sp))
        ]);
  }

  Column _nameEmail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user!.displayName.toString(), style: AppFontStyles.bold18),
        Text(user!.email.toString(), style: AppFontStyles.regular14),
      ],
    );
  }

  Container _avatar(ThemeMode mode) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
        BoxShadow(
            color: Colors.black38,
            spreadRadius: 0.sp,
            blurRadius: 1.5.sp,
            offset: Offset(1.sp, 1.sp))
      ]),
      child: CircleAvatar(
        backgroundColor: AppColors.primary,
        radius: 30.sp,
        child: Text(
          "M",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40.sp,
              color: mode == ThemeMode.dark
                  ? AppColors.AppTabBarDarkModeColor
                  : Colors.white,
              fontFamily: "Satoshi"),
        ),
      ),
    );
  }
}
