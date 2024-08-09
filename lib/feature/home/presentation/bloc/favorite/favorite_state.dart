// part of 'like_bloc.dart';



// import 'package:equatable/equatable.dart';

// class LikeState extends Equatable {
//   final List<String> likedSongs;

//   LikeState({required this.likedSongs});

//   factory LikeState.initial() {
//     return LikeState(likedSongs: []);
//   }

//   LikeState copyWith({List<String>? likedSongs}) {
//     return LikeState(
//       likedSongs: likedSongs ?? this.likedSongs,
//     );
//   }

//   @override
//   List<Object?> get props => [likedSongs];

//   factory LikeState.fromMap(Map<String, dynamic> map) {
//     return LikeState(
//       likedSongs: List<String>.from(map['likedSongs']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'likedSongs': likedSongs,
//     };
//   }
// }

// abstract class LikeEvent extends Equatable {
//   const LikeEvent();

//   @override
//   List<Object> get props => [];
// }

// class ToggleLike extends LikeEvent {
//   final String songId;

//   const ToggleLike(this.songId);

//   @override
//   List<Object> get props => [songId];
// }