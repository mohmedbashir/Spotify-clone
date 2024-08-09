import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_songs_usecasse.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_liked_sings_usecase.dart';

part 'liked_songs_state.dart';

class LikedSongsCubit extends Cubit<LikedSongsState> {
  LikedSongsCubit() : super(LikedSongsLoading());

  Future<void> fetchLikedSongs() async {
    emit(LikedSongsLoading());
    var result = await serviceLocator<FetchLikedSongsUsecase>().call();
    var likedSongsIds = [];
    List<SongEntity> likedSongs = [];
    result!.fold((l) {
      emit(LikedSongsFailed());
    }, (songs) {
      print(songs);
      likedSongsIds = songs;
    });
    if (likedSongsIds.isEmpty) {
      emit(NoLikedSongsYet());
    }

    for (String id in likedSongsIds) {
      await FirebaseFirestore.instance
          .collection('songs')
          .doc(id)
          .get()
          .then((DocumentSnapshot doc) {
        likedSongs.add(SongEntity(
            id: doc.id,
            name: doc.get('name'),
            artist: doc.get('artist'),
            coverPhoto: doc.get('cover'),
            duration: doc.get('duration'),
            // isLiked: isLiked!,
            url: doc.get('song')));
      });
      emit(LikedSongsLoaded(likedSongs: likedSongs));
    }
  }
}
