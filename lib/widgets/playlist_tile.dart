import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final Map<String, dynamic> playlist;
  final VoidCallback onRemove;

  PlaylistTile({
    required this.playlist,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(playlist['id'] ?? 'Unknown Playlist'),
      subtitle: Text('Songs: ${(playlist['songs'] as List<dynamic>).length}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onRemove,
      ),
    );
  }
}
