import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  //takes aspect ratio and video player URL
  final VideoPlayerController videoPlayerController;
  final double aspectRatio;

  ChewieListItem(
      {Key key, @required this.videoPlayerController, this.aspectRatio})
      : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoInitialize: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            //returns error message if user is not connected to wifi
            'Please check wifi settings',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 5, left: 5, bottom: 35),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    //video player is stopped when screen is exited
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
