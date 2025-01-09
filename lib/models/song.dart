class Song {
  final String id;
  final String title;
  final String artist;
  final String thumbnailUrl;
  final String url;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'].toString(),
      title: json['title'] ?? 'Unknown Title',
      artist: json['artist']['name'] ?? 'Unknown Artist',
      thumbnailUrl: json['album']['cover_medium'] ?? '',
      url: json['preview'] ?? '', // Use 'preview' from Deezer API
    );
  }
}
