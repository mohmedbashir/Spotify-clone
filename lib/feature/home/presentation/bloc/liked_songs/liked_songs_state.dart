part of 'liked_songs_cubit.dart';

sealed class LikedSongsState {
  const LikedSongsState();
}

// class NewSongsInitial extends NewSongsState {}

// class SongsLoading extends SongsState {}

class LikedSongsLoading extends LikedSongsState {}

class LikedSongsLoaded extends LikedSongsState {
  final List<SongEntity> likedSongs;

  LikedSongsLoaded({required this.likedSongs});
}

class LikedSongsFailed extends LikedSongsState {}

class NoLikedSongsYet extends LikedSongsState {}

// class SongsLoaded extends SongsState {
//   final List<SongEntity> songs;

//   SongsLoaded({required this.songs});
// }
