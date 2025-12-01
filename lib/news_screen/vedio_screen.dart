import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? videoController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        chewieController = ChewieController(
          videoPlayerController: videoController!,
          autoPlay: true,
          looping: false,
        );
        setState(() {});
      });
  }

  @override
  void dispose() {
    videoController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Watch Video")),
      body: Center(
        child: chewieController != null &&
            chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: chewieController!)
            : CircularProgressIndicator(),
      ),
    );
  }
}
