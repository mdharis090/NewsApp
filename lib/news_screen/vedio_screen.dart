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
  bool loading = true;
  bool errorLoading = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() async {
    try {
      videoController = VideoPlayerController.network(widget.videoUrl);
      await videoController!.initialize();

      if (!mounted) return;

      chewieController = ChewieController(
        videoPlayerController: videoController!,
        autoPlay: true,
        looping: false,
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Error loading video: $e");
      if (!mounted) return;
      setState(() {
        loading = false;
        errorLoading = true;
      });
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Watch Video")),
      body: Center(
        child: loading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Loading video..."),
          ],
        )
            : errorLoading
            ? Text(
          "Failed to load video.",
          style: TextStyle(color: Colors.red),
        )
            : Chewie(controller: chewieController!),
      ),
    );
  }
}
