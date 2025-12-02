import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_api/news_api_screen.dart';
import 'news_screen/news_screen_controller/news_bloc.dart';
import 'news_screen/news_screen_controller/news_event.dart';
import 'news_screen/news_screen_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (_) => NewsBloc(newsService: NewsService())..add(FetchNews(query: "Top")),
        child: NewsScreen(),
      ),
    );
  }
}
