import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNews extends NewsEvent {
  final String query;
  FetchNews({required this.query});

  @override
  List<Object?> get props => [query];
}

class ChangeCategory extends NewsEvent {
  final String category;
  ChangeCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
