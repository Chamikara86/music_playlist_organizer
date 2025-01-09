import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/playlist_provider.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _playlistController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PlaylistProvider>(context, listen: false)
        .loadPlaylistsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final playlistProvider = Provider.of<PlaylistProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('My Playlists')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _playlistController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Playlist Name',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_playlistController.text.isNotEmpty) {
                      playlistProvider.addPlaylist(_playlistController.text);
                      _playlistController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: playlistProvider.playlists.isEmpty
                ? Center(child: Text('No playlists yet.'))
                : ListView.builder(
                    itemCount: playlistProvider.playlists.keys.length,
                    itemBuilder: (context, index) {
                      final playlistName =
                          playlistProvider.playlists.keys.elementAt(index);
                      final songs =
                          playlistProvider.playlists[playlistName] ?? [];
                      return ListTile(
                        title: Text(playlistName),
                        subtitle: Text('${songs.length} songs'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            playlistProvider.removePlaylist(playlistName);
                          },
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Add Song to $playlistName'),
                                content: TextField(
                                  onSubmitted: (songTitle) {
                                    if (songTitle.isNotEmpty) {
                                      playlistProvider.addSongToPlaylist(
                                          playlistName, songTitle);
                                      Navigator.pop(context);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Song Title',
                                  ),
                                ),
                              );
                            },
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
