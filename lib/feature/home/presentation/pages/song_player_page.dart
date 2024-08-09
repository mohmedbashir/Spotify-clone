import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/utils/spacing.dart';
import 'package:spotify/core/utils/theme/colors.dart';
import 'package:spotify/core/common/widgets/app_bar.dart';
import 'package:spotify/core/helpers/format_duration.dart';
import 'package:spotify/core/utils/theme/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_liked_sings_usecase.dart';
import 'package:spotify/feature/home/presentation/bloc/favorite/favourite_cubit.dart';
import 'package:spotify/feature/home/presentation/bloc/liked_songs/liked_songs_cubit.dart';
import 'package:spotify/feature/home/presentation/bloc/song_player/song_player_cubit.dart';
// import 'package:like_button/like_button.dart';
// import 'package:spotify/core/injection/service_locator.dart';
// import 'package:spotify/feature/home/logic/usecases/like_unlike_usecase.dart';
// import 'package:spotify/feature/home/logic/usecases/check_if_liked_usecase.dart';
// import 'package:like_button/like_button.dart';
// import 'package:spotify/feature/home/presentation/bloc/favorite/favourite_cubit.dart';
// import 'package:spotify/feature/home/data/model/song.dart';

class SongPlayerPage extends StatefulWidget {
  const SongPlayerPage({
    super.key,
    required this.song,
    required this.isLiked,
  });
  final SongEntity song;
  final bool isLiked;

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(widget.song.url),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                onBackPressed: () => Get.back(),
                title: "Now Playing",
              ),
              verticalSpaceing(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
                  builder: (context, state) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _songCover(widget.song.coverPhoto),
                          verticalSpaceing(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _songArtistName(),
                              _likeButton(widget.song.id, widget.isLiked)
                            ],
                          ),
                          verticalSpaceing(10),
                          (state is SongLoadedState)
                              ? Column(
                                  children: [
                                    _slider(context),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _currentPosition(context),
                                        _songDuration(context),
                                      ],
                                    ),
                                  ],
                                )
                              : Slider(value: 0, onChanged: (c) {}),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.repeat, size: 35.sp),
                              Icon(Icons.skip_previous_rounded, size: 35.sp),
                              _playPuaseButton(),
                              Icon(Icons.skip_next_rounded, size: 35.sp),
                              Icon(Icons.shuffle_rounded, size: 35.sp)
                            ],
                          )
                        ]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _likeButton(String songId, bool isLiked) {
    return BlocProvider(
      create: (context) => LikeCubit(isLiked),
      child: BlocBuilder<LikeCubit, bool>(
        builder: (context, isLikedd) {
          return BlocProvider(
            create: (ctx) => LikedSongsCubit(),
            child: BlocBuilder<LikedSongsCubit, LikedSongsState>(
              builder: (ctx, state) {
                return InkWell(
                  borderRadius: BorderRadius.circular(50.sp),
                  onTap: () async {
                    context.read<LikeCubit>().toggle(songId);
                    // ctx.read<LikedSongsCubit>().fetchLikedSongs();
                    // BlocProvider.of<LikedSongsCubit>(context).fetchLikedSongs();
                  },
                  child: Icon(Icons.favorite_rounded,
                      size: 30.sp, color: isLikedd ? Colors.red : Colors.grey),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Column _songArtistName() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.song.name, style: AppFontStyles.bold20),
        SizedBox(
          width: Get.width * .7,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(widget.song.artist, style: AppFontStyles.regular17),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _playPuaseButton() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        AudioPlayer audioPlayer = context.read<SongPlayerCubit>().audioPlayer;
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 0.sp,
                    blurRadius: 4.sp,
                    offset: Offset(1.5.sp, 1.5.sp))
              ]),
          child: InkWell(
            onTap: () {
              if (state is SongLoadedState) {
                context.read<SongPlayerCubit>().togglePlayOrPuase();
                if (audioPlayer.playing) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              }
            },
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.primary,
                child: state is SongLoadingState
                    ? const CupertinoActivityIndicator(
                        radius: 20, color: Colors.white)
                    : AnimatedIcon(
                        size: 40.sp,
                        icon: AnimatedIcons.pause_play,
                        color: Colors.white,
                        progress: controller)

                //     Icon(
                //   context.read<SongPlayerCubit>().audioPlayer.playing
                //       ? Icons.pause_outlined
                //       : Icons.play_arrow_rounded,
                //   color: Get.isDarkMode
                //       ? AppColors.darkBackground
                //       : AppColors.lightBackground,
                //   size: 50.sp,
                // ),
                ),
          ),
        );
      },
    );
  }

  Text _songDuration(BuildContext context) {
    return Text(
        formatDuration(context.read<SongPlayerCubit>().songDuration.inSeconds));
  }

  Text _currentPosition(BuildContext context) {
    return Text(
        formatDuration(context.read<SongPlayerCubit>().songPosition.inSeconds));
  }

  Slider _slider(BuildContext context) {
    return Slider(
        activeColor: AppColors.darkGrey,
        value:
            context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
        min: 0.0,
        max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
        onChanged: (value) {
          context.read<SongPlayerCubit>().onSliderChanged(value);
        });
  }

  Widget _songCover(String image) {
    return Hero(
      tag: image,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          BoxShadow(
              color: Colors.black38,
              spreadRadius: 0.sp,
              blurRadius: 4.sp,
              offset: Offset(1.5.sp, 1.5.sp))
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 400.h,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
