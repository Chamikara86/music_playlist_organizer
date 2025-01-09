import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class MusicProvider with ChangeNotifier {
  List<Song> _songs = [];
  List<Song> _favorites = []; // List to store favorite songs
  bool _isLoading = false;

  List<Song> get songs => _songs;
  List<Song> get favorites => _favorites; // Expose favorites
  bool get isLoading => _isLoading;

  // Add song to favorites
  void addToFavorites(Song song) {
    if (!_favorites.contains(song)) {
      _favorites.add(song);
      notifyListeners();
    }
  }

  // Remove song from favorites
  void removeFromFavorites(Song song) {
    _favorites.remove(song);
    notifyListeners();
  }

  Future<void> fetchSongs(String query) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.deezer.com/search?q=$query');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _songs =
            (data['data'] as List).map((json) => Song.fromJson(json)).toList();
      } else {
        _songs = [];
      }
    } catch (error) {
      _songs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRandomSongs() async {
    await fetchSongs('trending');
  }
}
