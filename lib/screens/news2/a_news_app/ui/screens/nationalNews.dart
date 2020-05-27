import 'package:lakhimpur_kheri/screens/news2/a_news_app/blocs/news_bloc.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/screens/localNews.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/search_bar.dart';
import 'package:lakhimpur_kheri/screens/news2/a_news_app/ui/views/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:lakhimpur_kheri/screens/news/helper/widgets.dart';

ScrollController scrollControllerNationalNewsList;

class NationalNews extends StatefulWidget {
  @override
  createState() => NationalNewsState();
}

class NationalNewsState extends State<NationalNews> {

  TabController tabController;

  @override
  void initState() {
    setState(() {});
    scrollControllerNationalNewsList = ScrollController(initialScrollOffset: 84);
    super.initState();
    bloc.fetchAllNews();
  }

  @override
  void dispose() {
    scrollControllerNationalNewsList.dispose();
    super.dispose();
  }

  MyAppBar() {
    return AppBar(
      title: title("National", "HeadLines"),
      elevation: 4,
      backgroundColor: Colors.orangeAccent,
      bottom: TabBar(
        labelColor: Colors.orangeAccent,
        labelStyle: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black,),
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        indicatorColor: Colors.red,
        isScrollable: true,
        indicator: BoxDecoration(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        tabs: [
          Tabs("Latest"),
          Tabs("Education"),
          Tabs("Politics"),
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

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return DefaultTabController(
        length: 10,
        child: Scaffold(
          appBar: MyAppBar(),
          body: _tabBarView(),
        ));
  }


  Widget _tabBarView() {
    return TabBarView(controller: tabController, children: [
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
        child: CustomScrollView(
          controller: scrollControllerNationalNewsList,
          slivers: <Widget>[
            streamBuilder(bloc.allNews),
          ],
        ),
      ),
      SafeArea(
          child: CustomScrollView(
            controller: scrollControllerNationalNewsList,
            slivers: <Widget>[
              streamBuilder(bloc.allNews),
            ],
          )),
    ]);
  }

}