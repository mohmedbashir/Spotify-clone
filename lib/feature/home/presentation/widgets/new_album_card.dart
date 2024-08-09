import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/assets/assets.dart';
import 'package:spotify/core/common/widgets/app_bar.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewAlbumCard extends StatelessWidget {
  const NewAlbumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 239.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomAppBar(
                leadingIcon: CupertinoIcons.search,
                onBackPressed: () {
                  // serviceLocator<FetchSongsUsecase>().call();
                  // Get.to(() =>  MusicPlayerPage());
                }),
            _newAlbumCard(),
            _albumImage(),
          ],
        ),
      ),
    );
  }
}

Positioned _albumImage() {
  return Positioned(
      top: 78.5.h,
      right: 20,
      child: Image.asset(
        alignment: Alignment.centerRight,
        AppImages.bilie5,
        height: 160.h,
      ));
}

Positioned _newAlbumCard() {
  return Positioned(
    top: 120.h,
    child: Container(
      width: Get.width - 30.w,
      height: 118.h,
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                spreadRadius: 0.sp,
                blurRadius: 4.sp,
                offset: Offset(1.5.sp, 1.5.sp))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("New Album", style: AppFontStyles.whiteMedium10),
                SizedBox(
                    width: 150.w,
                    child: Text("Happier Than Ever",
                        style: AppFontStyles.whiteBold19)),
                Text("Billie Eilish", style: AppFontStyles.whiteMedium13),
              ],
            ),
          ),
          Image.asset(
            AppImages.topEffect,
            color: Colors.white,
          )
        ],
      ),
    ),
  );
}
