import 'package:flutter_bloc/flutter_bloc.dart';
import '../../news_api/news_api_screen.dart';
import 'news_event.dart';
import 'news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;
  String currentCategory = "Top";

  NewsBloc({required this.newsService}) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final data = await newsService.fetchNews(event.query);
        emit(NewsLoaded(articles: data));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });

    on<ChangeCategory>((event, emit) async {
      currentCategory = event.category;
      emit(NewsLoading());
      try {
        final data = await newsService.fetchNews(currentCategory);
        emit(NewsLoaded(articles: data));
      } catch (e) {
        emit(NewsError(message: e.toString()));
      }
    });
  }
}
