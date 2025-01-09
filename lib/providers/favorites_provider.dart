import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  Future<void> loadFavoritesFromDatabase() async {
    final data = await DatabaseHelper.instance.getFavorites();
    _favorites.clear();
    _favorites.addAll(data);
    notifyListeners();
  }

  void addFavorite(Map<String, dynamic> song) {
    _favorites.add(song);
    notifyListeners();
  }

  void removeFavorite(String id) {
    _favorites.removeWhere((song) => song['id'] == id);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favorites.any((song) => song['id'] == id);
  }
}
