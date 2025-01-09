import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../widgets/song_tile.dart';

class SongSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Search Songs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (query) {
                musicProvider.fetchSongs(query);
              },
              decoration: InputDecoration(
                hintText: 'Search for songs...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: musicProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: musicProvider.songs.length,
                    itemBuilder: (context, index) {
                      return SongTile(song: musicProvider.songs[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
