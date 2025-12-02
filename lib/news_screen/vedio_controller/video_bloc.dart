import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_event.dart';
import 'video_state.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<LoadVideo>((event, emit) async {
      emit(VideoLoading());
      try {
        final videoController = VideoPlayerController.network(event.url);
        await videoController.initialize();

        final chewieController = ChewieController(
          videoPlayerController: videoController,
          autoPlay: true,
          looping: false,
        );

        emit(VideoLoaded(videoController: videoController, chewieController: chewieController));
      } catch (e) {
        emit(VideoError(message: "Failed to load video: $e"));
      }
    });
  }

  @override
  Future<void> close() {
    if (state is VideoLoaded) {
      (state as VideoLoaded).chewieController.dispose();
      (state as VideoLoaded).videoController.dispose();
    }
    return super.close();
  }
}
