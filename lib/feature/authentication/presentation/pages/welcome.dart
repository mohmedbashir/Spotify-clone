import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/assets/assets.dart';
import 'package:spotify/core/utils/assets/vectors.dart';
import 'package:spotify/core/common/widgets/button.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/authentication/presentation/pages/signin.dart';
import 'package:spotify/feature/authentication/presentation/pages/signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _topEffect(),
          _bottomEffect(),
          _bottomImage(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  verticalSpaceing(40),
                  Text(
                    "Let's listen to music together",
                    style: AppFontStyles.bold25,
                  ),
                  verticalSpaceing(10),
                  Text(
                    "Spotify is a proprietary Swedish audio streaming and media services provider",
                    style: AppFontStyles.greyRegular17,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _registerButto(),
                      horizantalSpaceing(20),
                      _signInButton(),
                    ],
                  ),
                  verticalSpaceing(80),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppButton _signInButton() {
    return AppButton(
      label: "Sign in",
      onPressed: () {
        Get.to(SignInPage());
      },
      background: AppColors.lightBackground,
      width: 130,
      elevation: 0,
      labelColor: Colors.black,
    );
  }

  AppButton _registerButto() {
    return AppButton(
      label: "Register",
      onPressed: () {
        Get.to(SignUpPage());
      },
      width: 130,
    );
  }

  Align _bottomImage() {
    return Align(
        alignment: Alignment.bottomLeft, child: Image.asset(AppImages.bilie4));
  }

  Align _bottomEffect() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Image.asset(AppImages.bottomEffect));
  }

  Align _topEffect() {
    return Align(
        alignment: Alignment.topRight,
        child: Image.asset(
          AppImages.topEffect,
        ));
  }
}
