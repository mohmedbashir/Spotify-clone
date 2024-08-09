import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_songs_usecasse.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_liked_sings_usecase.dart';

part 'new_songs_state.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> fetchNewSongs() async {
    var songs = await serviceLocator<FetchSongsUsecase>().call();

    songs!.fold((l) {
      emit(NewSongsFailed());
    }, (songs) {
      emit(NewSongsLoaded(songs: songs));
    });
  }
}
