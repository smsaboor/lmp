import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/news_bloc.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/search_bar.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/stream_builder.dart';
import 'package:flutter/material.dart';

ScrollController scrollControllerNewsList;

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  TabController tabController;

  @override
  void initState() {
    setState(() {});
    scrollControllerNewsList = ScrollController(initialScrollOffset: 84);
    super.initState();
    bloc.fetchAllNews();
  }

  @override
  void dispose() {
    scrollControllerNewsList.dispose();
    super.dispose();
  }
  MyAppBar() {
    return AppBar(
      elevation: 4,
      title: Text("Color"),
      bottom: TabBar(
        labelColor: Colors.orangeAccent,
        labelStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        indicatorColor: Colors.red,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        isScrollable: true,
        tabs: [
          Tabs("Latest"),
          Tabs("India"),
          Tabs("World"),
          Tabs("Business"),
          Tabs("Entertainment"),
          Tabs("General"),
          Tabs("Health"),
          Tabs("Science"),
          Tabs("Sports"),
          Tabs("Technology"),
        ],
        controller: tabController,
      ),
    );
  }
  Widget Tabs(String tabn){
    return Tab(
      child: Text(tabn,
          style:
          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0)),
    );
  }
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: MyAppBar(),
        body:SingleChildScrollView(
          child:streamBuilder(bloc.allNews),
      ),
    );
  }
}
