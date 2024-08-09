import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/feature/home/logic/entity/song.dart';
// import 'package:spotify/core/injection/service_locator.dart';
// import 'package:spotify/feature/home/logic/usecases/check_if_liked_usecase.dart';

abstract class SongsDataSource {
  Future<Either> fetchSongs();
  Future<Either> likeOrUnlike(String songId);
  Future<Either> isLikedSong(String songId);
  Future<Either> fetchLikedSongs();
}

class SongsDataSourceImplementation extends SongsDataSource {
  final songsDocRef = FirebaseFirestore.instance.collection('songs');
  // final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<Either> fetchSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await songsDocRef.get();
      for (var element in data.docs) {
        songs.add(SongEntity(
            id: element.id,
            name: element.data()['name'],
            artist: element.data()['artist'],
            coverPhoto: element.data()['cover'],
            duration: element.data()['duration'],
            // isLiked: isLiked!,
            url: element.data()['song']));
      }

      return Right(songs);
    } on Exception catch (e) {
      return left("$e");
    }
  }

  @override
  Future<Either> likeOrUnlike(String songId) async {
    //userID
    try {
      //userDocRef
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      //userDocRefDAta
      var userDocRefData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      //check if the user doc has field named "likedSongs", if not add it .
      if (!userDocRefData.data()!.containsKey('likedSongs')) {
        print("is not exist");
        await userDocRef.update({'likedSongs': []});
      }

      //get liked songs
      var userData = FirebaseFirestore.instance.collection('users').doc(userId);
      userDocRefData = await userData.get();

      var likedSongs = await userDocRefData.get('likedSongs');

      //check if the song is in liked songs List, if yes delete if , if not add it.
      if (!likedSongs.contains(songId)) {
        await userDocRef.update({
          'likedSongs': FieldValue.arrayUnion([songId])
        });
      } else {
        await userDocRef.update({
          'likedSongs': FieldValue.arrayRemove([songId])
        });
      }
      return Right("likedSongs");
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> isLikedSong(String songId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var userDocRefData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDocRefData.data()!.containsKey('likedSongs')) {
        List likedSongs = await userDocRefData.get('likedSongs');
        if (likedSongs.contains(songId)) {
          return Right(true);
        } else {
          return Right(false);
        }
      } else
        return Right(false);
    } on Exception catch (e) {
      return Left(false);
    }
  }

  @override
  Future<Either> fetchLikedSongs() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var userDocRefData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDocRefData.data()!.containsKey('likedSongs')) {
        List likedSongs = await userDocRefData.get('likedSongs');
        // print(likedSongs.length);
        return Right(likedSongs);
      } else {
        return Right([]);
      }
    } on Exception catch (e) {
      return Left(e.toString);
    }
  }

  Stream<Either<dynamic, List<SongEntity>>> fetchLikedSongsStream() async* {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var userDocRefData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDocRefData.data()!.containsKey('likedSongs')) {
        List<SongEntity> likedSongs = userDocRefData.get('likedSongs');
        yield Right(likedSongs);
      } else {
        yield Right([]);
      }
    } on Exception catch (e) {
      yield Left(e.toString());
    }
  }
}
