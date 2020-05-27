import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/news_bloc.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/search_bar.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ScrollController scrollControllerWorldNewsList;

class LocalNews extends StatefulWidget {
  @override
  createState() => LocalNewsState();
}

class LocalNewsState extends State<LocalNews> {
  TabController tabController;

  @override
  void initState() {
    setState(() {});
    scrollControllerWorldNewsList = ScrollController(initialScrollOffset: 84);
    super.initState();
  }

  @override
  void dispose() {
    scrollControllerWorldNewsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllNews();
    setState(() {});
    return
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerWorldNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      );
  }
}
