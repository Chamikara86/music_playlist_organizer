import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'player_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: musicProvider.favorites.isEmpty
          ? Center(child: Text('No favorite songs added yet.'))
          : ListView.builder(
              itemCount: musicProvider.favorites.length,
              itemBuilder: (context, index) {
                final song = musicProvider.favorites[index];
                return ListTile(
                  leading: song.thumbnailUrl.isNotEmpty
                      ? Image.network(
                          song.thumbnailUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.music_note, size: 50),
                  title: Text(song.title),
                  subtitle: Text(song.artist),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      musicProvider.removeFromFavorites(song);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(song: song),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
