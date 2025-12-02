// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:chewie/chewie.dart';
// import 'package:newsap/news_screen/vedio_controller/video_bloc.dart';
// import 'package:newsap/news_screen/vedio_controller/video_event.dart';
// import 'package:newsap/news_screen/vedio_controller/video_state.dart';
//
// class VideoPlayerScreen extends StatelessWidget {
//   final String videoUrl;
//   VideoPlayerScreen({required this.videoUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => VideoBloc()..add(LoadVideo(url: videoUrl)),
//       child: Scaffold(
//         appBar: AppBar(title: Text("Watch Video")),
//         body: BlocBuilder<VideoBloc, VideoState>(
//           builder: (context, state) {
//             if (state is VideoLoading) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 10),
//                     Text("Loading video..."),
//                   ],
//                 ),
//               );
//             } else if (state is VideoError) {
//               return Center(
//                 child: Text(state.message, style: TextStyle(color: Colors.red)),
//               );
//             } else if (state is VideoLoaded) {
//               return Chewie(controller: state.chewieController);
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chewie/chewie.dart';
import 'package:newsap/news_screen/vedio_controller/video_bloc.dart';
import 'package:newsap/news_screen/vedio_controller/video_event.dart';
import 'package:newsap/news_screen/vedio_controller/video_state.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  VideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoBloc()..add(LoadVideo(url: videoUrl)),
      child: Scaffold(
        appBar: AppBar(title: Text("Watch Video")),
        body: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is VideoError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
            } else if (state is VideoLoaded) {
              return Chewie(controller: state.chewieController);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
