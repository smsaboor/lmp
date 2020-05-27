import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/news_bloc.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/search_bar.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/stream_builder.dart';
import 'package:flutter/material.dart';

ScrollController scrollControllerForYouList;

class ForYou extends StatefulWidget {
  @override
  createState() => ForYouState();
}

class ForYouState extends State<ForYou> {
  @override
  void initState() {
    setState(() {});
    scrollControllerForYouList = ScrollController(initialScrollOffset: 84);
    super.initState();

  }

  @override
  void dispose() {
    scrollControllerForYouList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllNews();
    setState(() {});
    return SafeArea(
      child: CustomScrollView(
        controller: scrollControllerForYouList,
        slivers: <Widget>[
          buildSearchBar(context), // Serach
          streamBuilder(bloc.allNews),
        ],
      ),
    );
  }
}