import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/feature/home/presentation/pages/song_player_page.dart';
import 'package:spotify/feature/home/presentation/bloc/new_songs/new_songs_cubit.dart';

class TrendingSongsList extends StatelessWidget {
  const TrendingSongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewSongsCubit, NewSongsState>(
      builder: (context, state) {
        if (state is NewSongsLoading) {
          return _shimmer();
        } else if (state is NewSongsFailed) {
          return const Center(child: Text("Sorry , there is a problem"));
        } else if (state is NewSongsLoaded) {
          List songs = state.songs.reversed.toList();

          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => Column(
              children: [
                ListTile(
                  onTap: () {
                    Get.to(SongPlayerPage(song: songs[index], isLiked: false));
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _playButton(),
                          horizantalSpaceing(15),
                          _songNameArtist(
                            songs[index].name,
                            songs[index].artist,
                          ),
                          const Spacer(),
                          _duration(state.songs[index].duration),

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
            ),
            childCount: songs.length,
          ));
        }
        return Container();
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
  return SliverList(
      delegate: SliverChildBuilderDelegate(
    (context, index) => Column(
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
    childCount: 10,
  ));
}
