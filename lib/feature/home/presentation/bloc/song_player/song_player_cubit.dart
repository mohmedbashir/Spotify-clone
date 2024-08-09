import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongLoadingState()) {
    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
      updatePlayer();
    });
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updatePlayer();
    });
  }

  void onSliderChanged(value) {
    var position = Duration(
        seconds: value.toInt(),
        milliseconds: ((value - value.toInt()) * 1000).toInt());
    audioPlayer.seek(position);
    updatePlayer();
  }

  void updatePlayer() {
    emit(SongLoadedState());
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
      // Future.delayed(const Duration(seconds: 5));
      emit(SongLoadedState());
    } catch (e) {
      emit(SongFailureState());
    }
  }

  void togglePlayOrPuase() {
    emit(SongLoadingState());
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongLoadedState());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
