import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadVideo extends VideoEvent {
  final String url;
  LoadVideo({required this.url});

  @override
  List<Object?> get props => [url];
}
