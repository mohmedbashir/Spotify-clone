import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotify/feature/home/presentation/pages/song_player_page.dart';
import 'package:spotify/feature/home/logic/usecases/check_if_liked_usecase.dart';
import 'package:spotify/feature/home/presentation/bloc/new_songs/new_songs_cubit.dart';

class NewSongsList extends StatelessWidget {
  const NewSongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSongsCubit, NewSongsState>(
      builder: (context, state) {
        if (state is NewSongsLoading) {
          return _shimmerEffect();
        } else if (state is NewSongsLoaded) {
          List<SongEntity> songs = state.songs;
          // return _shimmerEffect();
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 277.h,
              child: ListView.separated(
                separatorBuilder: (context, index) => horizantalSpaceing(15),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: songs.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 15.h, top: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _songCover(songs[index]),
                      verticalSpaceing(7),
                      _songName(songs[index].name),
                      verticalSpaceing(2),
                      _artistName(songs[index].artist)
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("Sorry , there is a problem"));
        }
      },
    );
  }
}

Widget _artistName(String artistName) => SizedBox(
    width: 130.w,
    child: Text(
      artistName,
      style: AppFontStyles.regular14,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    ));

Widget _songName(String songName) => SizedBox(
    width: 130.w,
    child: Text(
      songName,
      style: AppFontStyles.bold16,
      textAlign: TextAlign.center,
    ));

Widget _songCover(SongEntity song) {
  bool isLiked = false;
  return GestureDetector(
    onTap: () async {
      var result =
          await serviceLocator<CheckIfLikedUsecase>().call(params: song.id);

      result!.fold((err) {
        print("Error: $err");
        print("Updated isLiked value: $isLiked");
      }, (value) {
        isLiked = value;
      });

      // Now that the asynchronous operation is complete, navigate to the next page
      print("song is $isLiked");
      Get.to(SongPlayerPage(song: song, isLiked: isLiked));
    },
    child: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        BoxShadow(
            color: Colors.black38,
            spreadRadius: 0.sp,
            blurRadius: 4.sp,
            offset: Offset(1.5.sp, 1.5.sp))
      ]),
      child: Hero(
        tag: song.coverPhoto,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl: song.coverPhoto,
            placeholder: (context, url) => _singleShimmer(),
            fit: BoxFit.cover,
            height: 200.h,
            width: 150.w,
          ),
        ),
      ),
    ),
  );
}

Widget _shimmerEffect() {
  return SliverToBoxAdapter(
    child: SizedBox(
      height: 277.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor:
              Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade300,
          highlightColor:
              Get.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade100,
          child: Column(
            children: [
              verticalSpaceing(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.sp),
                child: Container(
                  height: 200.h,
                  width: 150.w,
                  color: AppColors.grey,
                ),
              ),
              verticalSpaceing(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.sp),
                child: Container(
                  width: 90.w,
                  height: 10.h,
                  color: AppColors.lightGrey,
                ),
              ),
              verticalSpaceing(7),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.sp),
                child: Container(
                  width: 70.w,
                  height: 10.h,
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          ),
        ),
        itemCount: 7,
        separatorBuilder: (context, index) => horizantalSpaceing(15),
      ),
    ),
  );
}

Widget _singleShimmer() {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          // verticalSpaceing(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.sp),
            child: Container(
              height: 200.h,
              width: 150.w,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ));
}
