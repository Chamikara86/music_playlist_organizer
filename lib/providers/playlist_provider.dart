import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PlaylistProvider with ChangeNotifier {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('playlists');

  Map<String, List<String>> _playlists = {};

  Map<String, List<String>> get playlists => _playlists;

  // Load playlists from Firebase
  Future<void> loadPlaylistsFromFirebase() async {
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      _playlists = data.map((key, value) {
        return MapEntry(key as String, List<String>.from(value['songs'] ?? []));
      });
      notifyListeners();
    }
  }

  // Add playlist
  Future<void> addPlaylist(String name) async {
    if (!_playlists.containsKey(name)) {
      await _dbRef.child(name).set({'songs': []});
      _playlists[name] = [];
      notifyListeners();
    }
  }

  // Add a song to a playlist
  Future<void> addSongToPlaylist(String playlistName, String songTitle) async {
    if (_playlists.containsKey(playlistName)) {
      _playlists[playlistName]?.add(songTitle);
      await _dbRef.child(playlistName).set({'songs': _playlists[playlistName]});
      notifyListeners();
    }
  }

  // Remove a playlist
  Future<void> removePlaylist(String name) async {
    if (_playlists.containsKey(name)) {
      await _dbRef.child(name).remove();
      _playlists.remove(name);
      notifyListeners();
    }
  }
}
