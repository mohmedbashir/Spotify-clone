import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
import 'package:spotify/feature/home/presentation/pages/song_player_page.dart';
import 'package:spotify/feature/home/presentation/bloc/new_songs/new_songs_cubit.dart';
import 'package:spotify/feature/home/presentation/bloc/liked_songs/liked_songs_cubit.dart';
// import 'package:spotify/feature/home/presentation/widgets/home_widgets.dart';

class LikedSongsPage extends StatelessWidget {
  const LikedSongsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedSongsCubit, LikedSongsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Favorite Songs",
              style: AppFontStyles.bold20,
            ),
            backgroundColor: Get.isDarkMode ? Color(0xff343434) : Colors.white,
          ),
          body: state is LikedSongsLoaded
              ? CustomScrollView(slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: state.likedSongs.length,
                        (context, index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Get.to(SongPlayerPage(
                                        song: state.likedSongs[index],
                                        isLiked: true));
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          _playButton(),
                                          horizantalSpaceing(15),
                                          _songNameArtist(
                                            state.likedSongs[index].name,
                                            state.likedSongs[index].artist,
                                          ),
                                          const Spacer(),
                                          _duration(
                                              state.likedSongs[index].duration),

                                          // _favoriteButton(),
                                          // horizantalSpaceing(5),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Container(
                                      height: 1.h,
                                      width: 250.w,
                                      color: AppColors.grey.withOpacity(.3)),
                                )
                              ],
                            )),
                  ),
                ])
              : state is NoLikedSongsYet
                  ? Center(child: Text("There is no Liked songs yet."))
                  : state is LikedSongsLoading
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : Text("data"),
        );
      },
    );
  }

  CircleAvatar _playButton() {
    return CircleAvatar(
      backgroundColor: Colors.grey.withOpacity(.2),
      radius: 25.sp,
      child: Icon(
        Icons.play_arrow_rounded,
        color: AppColors.grey,
        size: 35.sp,
      ),
    );
  }

  Text _duration(String duration) {
    return Text(
      duration,
      style: AppFontStyles.regular14,
    );
  }

  Column _songNameArtist(String songName, artistName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(songName, style: AppFontStyles.bold16),
        SizedBox(
          width: Get.width * .6,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(artistName, style: AppFontStyles.regular14),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _shimmer() {
  return ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) => Column(
      children: [
        Shimmer.fromColors(
          baseColor:
              Get.isDarkMode ? Colors.grey.shade500 : Colors.grey.shade300,
          highlightColor:
              Get.isDarkMode ? Colors.grey.shade400 : Colors.grey.shade100,
          child: ListTile(
            onTap: () {},
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      radius: 25.sp,
                    ),
                    horizantalSpaceing(15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.sp),
                          child: Container(
                              width: 90,
                              height: 10,
                              color: AppColors.lightGrey),
                        ),
                        verticalSpaceing(10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.sp),
                          child: Container(
                              width: 70, height: 8, color: AppColors.lightGrey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.sp),
                          child: Container(
                              width: 30,
                              height: 10,
                              color: AppColors.lightGrey),
                        ),
                      ],
                    ),
                    horizantalSpaceing(15),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child:
              Container(height: 1.h, width: 250.w, color: AppColors.lightGrey),
        )
      ],
    ),
  );
}
