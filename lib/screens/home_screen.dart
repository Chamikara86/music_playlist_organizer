import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<MusicProvider>(context, listen: false).fetchRandomSongs();
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Music Playlist Organizer')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (query) {
                musicProvider.fetchSongs(query);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search Songs',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    musicProvider.fetchSongs(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: musicProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: musicProvider.songs.length,
                    itemBuilder: (context, index) {
                      final song = musicProvider.songs[index];
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
                          icon: Icon(
                            Icons.favorite,
                            color: musicProvider.favorites.contains(song)
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            if (musicProvider.favorites.contains(song)) {
                              musicProvider.removeFromFavorites(song);
                            } else {
                              musicProvider.addToFavorites(song);
                            }
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
          ),
        ],
      ),
    );
  }
}
