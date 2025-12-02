import 'package:equatable/equatable.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

abstract class VideoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final VideoPlayerController videoController;
  final ChewieController chewieController;

  VideoLoaded({required this.videoController, required this.chewieController});

  @override
  List<Object?> get props => [videoController, chewieController];
}

class VideoError extends VideoState {
  final String message;
  VideoError({required this.message});

  @override
  List<Object?> get props => [message];
}
