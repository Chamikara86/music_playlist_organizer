import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  PlayerScreen({required this.song});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // Load and play the song URL
    _audioPlayer.setUrl(widget.song.url).then((_) {
      _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Now Playing')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.song.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(widget.song.artist, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Icon(Icons.music_note, size: 100),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                  if (isPlaying) {
                    _audioPlayer.play();
                  } else {
                    _audioPlayer.pause();
                  }
                },
              ),
              IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
