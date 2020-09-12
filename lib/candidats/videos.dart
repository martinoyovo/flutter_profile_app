import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  final DocumentSnapshot videos;

  final VideoPlayerController videoPlayerController;
  final bool looping;

  Videos({
    @required this.videoPlayerController,
    this.looping,
    Key key, this.videos,
  }): super(key: key);





  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController:  widget.videoPlayerController,
      aspectRatio: 3/2,
      autoInitialize: true,
      looping: widget.looping,

      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Erreur connexion',
            style: TextStyle(color: Colors.white, fontFamily: 'Open Sans'),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(10),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();

    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
