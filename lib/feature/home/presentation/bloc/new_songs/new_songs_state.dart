part of 'new_songs_cubit.dart';

sealed class NewSongsState {
  const NewSongsState();
}

class NewSongsLoading extends NewSongsState {}

class NewSongsFailed extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<SongEntity> songs;

  NewSongsLoaded({required this.songs});
}
