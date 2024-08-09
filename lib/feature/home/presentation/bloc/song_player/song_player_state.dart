part of 'song_player_cubit.dart';

sealed class SongPlayerState {
  const SongPlayerState();
}

final class SongLoadingState extends SongPlayerState {}

final class SongLoadedState extends SongPlayerState {}

final class SongFailureState extends SongPlayerState {}
