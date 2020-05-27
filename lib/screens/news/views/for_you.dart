import 'package:lakhimpur_kheri/screens/news/blocs/news_bloc.dart';
import 'package:lakhimpur_kheri/screens/news/stream_builder_newsaapp.dart';
import 'package:flutter/material.dart';

ScrollController scrollControllerNewsList;

class ForYou extends StatefulWidget {
  @override
  createState() => ForYouState();
}

class ForYouState extends State<ForYou> {
  @override
  void initState() {
    setState(() {});
    scrollControllerNewsList = ScrollController(initialScrollOffset: 84);
    super.initState();
  }

  @override
  void dispose() {
    scrollControllerNewsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllNews();
    setState(() {});
    return SafeArea(
      child: CustomScrollView(
        controller: scrollControllerNewsList,
        slivers: <Widget>[
//          buildSearchBar(context), // Serach
          streamBuilder(bloc.allNews),
        ],
      ),
    );
  }
}