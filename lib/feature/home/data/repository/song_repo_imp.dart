import 'package:dartz/dartz.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/repositoy/song_repo.dart';
import 'package:spotify/feature/home/data/source/firebase_data_source.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> fetchSongs() {
    return serviceLocator<SongsDataSource>().fetchSongs();
  }

  @override
  Future<Either> likeOrUnlikeSong(String songId) {
    return serviceLocator<SongsDataSource>().likeOrUnlike(songId);
  }

  @override
  Future<Either> isLikedSong(String songId) {
    return serviceLocator<SongsDataSource>().isLikedSong(songId);
  }

  @override
  Future<Either> fetchLikedSongs() {
    return serviceLocator<SongsDataSource>().fetchLikedSongs();
  }
}
