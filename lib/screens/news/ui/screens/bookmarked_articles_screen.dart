import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/news/services/news_service.dart';
import 'package:lakhimpur_kheri/screens/news/ui/views/bookmarked_articles_view.dart';

class BookmarkedArticlesScreen extends StatelessWidget {
  final NewsService newsService;

  const BookmarkedArticlesScreen({Key key, this.newsService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BookmarkedArticlesView(newsService: newsService,);
  }
}
