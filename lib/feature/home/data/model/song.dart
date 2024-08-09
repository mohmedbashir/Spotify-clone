class SongModel {
  final String name;
  final String artist;
  final String cover;
  final String duration;
  final String song;

  SongModel(
      {required this.name,
      required this.artist,
      required this.cover,
      required this.duration,
      required this.song});

  factory SongModel.fromJson(Map<dynamic, String> json) {
    return SongModel(
        name: json['name'] as String,
        artist: json['artist'] as String,
        cover: json['cover'] as String,
        duration: json['duration'] as String,
        song: json['song'] as String);
  }
}
