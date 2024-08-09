class SongEntity {
  final String id;
  final String name;
  final String artist;
  final String coverPhoto;
  final String duration;
  final String url;
  // final bool isLiked;

  SongEntity(
      {required this.id,
      required this.name,
      required this.artist,
      required this.coverPhoto,
      required this.url,
      // required this.isLiked,
      required this.duration});
}
