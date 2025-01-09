import 'package:flutter/material.dart';
import '../models/song.dart';

class SongTile extends StatelessWidget {
  final Song song;

  SongTile({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      subtitle: Text(song.artist),
      leading: Image.network(song.thumbnailUrl),
    );
  }
}
