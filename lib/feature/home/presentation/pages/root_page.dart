import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/feature/home/presentation/pages/home_page.dart';
import 'package:spotify/feature/home/presentation/pages/profile_page.dart';
import 'package:spotify/feature/home/presentation/bloc/nav/nav_cubit.dart';
import 'package:spotify/feature/home/presentation/widgets/home_widgets.dart';
import 'package:spotify/feature/home/presentation/pages/liked_songs_page.dart';
import 'package:spotify/feature/home/presentation/bloc/new_songs/new_songs_cubit.dart';
import 'package:spotify/feature/home/presentation/bloc/liked_songs/liked_songs_cubit.dart';
// import 'package:spotify/feature/home/presentation/bloc/favorite/favourite_cubit.dart';
// import 'package:spotify/feature/home/presentation/bloc/favorite/favourite_cubit.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavBarCubit()),
          BlocProvider(create: (context) => NewSongsCubit()..fetchNewSongs()),
          // BlocProvider(
          //     create: (context) => LikedSongsCubit()..fetchLikedSongs()),
        ],
        child: BlocBuilder<NavBarCubit, int>(
          builder: (context, currentIndex) {
            // context.read<SongsCubit>().fetchLikedSongs();
            return Scaffold(
              body: tabs[currentIndex],
              bottomNavigationBar: const BottomNavBar(),
            );
          },
        ),
      ),
    );
  }
}

List<Widget> tabs = [
  HomePage(),
  BlocProvider(
    create: (context) => LikedSongsCubit()..fetchLikedSongs(),
    child: LikedSongsPage(),
  ),
  ProfilePage(),
];
