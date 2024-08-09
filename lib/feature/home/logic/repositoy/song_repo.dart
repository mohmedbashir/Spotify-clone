import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> fetchSongs();
  Future<Either> likeOrUnlikeSong(String songId);
  Future<Either> isLikedSong(String songId);
  Future<Either> fetchLikedSongs();
}
