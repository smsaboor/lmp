import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lakhimpur_kheri/screens/news/a_news_app/bottom_nav_bar.dart';

import 'package:lakhimpur_kheri/screens/news/helper/newssetting2.dart';
import 'package:lakhimpur_kheri/screens/news/app_menu.dart';
import 'package:lakhimpur_kheri/screens/news/helper/newsSetting.dart';
import 'package:lakhimpur_kheri/screens/news/helper/widgets.dart';
import 'package:lakhimpur_kheri/screens/news/ui/screens/onboarding_screen.dart';
import 'package:lakhimpur_kheri/screens/news/views/cloud_downlods.dart';
import 'package:lakhimpur_kheri/screens/news/views/for_you.dart';
import 'package:lakhimpur_kheri/screens/news/views/localnews.dart';
import 'package:lakhimpur_kheri/screens/news/a_news_app/ui/screens/serch_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:lakhimpur_kheri/screens/news/a_news_app/ui/views/search_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lakhimpur_kheri/screens/news/explore_news/homepage.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

//import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:lakhimpur_kheri/zCountryPicker/country.dart';
import 'package:lakhimpur_kheri/zCountryPicker/country_pickers.dart';

class NewsHome extends StatefulWidget {
  final SharedPreferences prefs;

  NewsHome({this.prefs});

  @override
  _NewsHomeState createState() => _NewsHomeState(prefs: prefs);
}

class _NewsHomeState extends State<NewsHome> {
  final SharedPreferences prefs;
  List<String> listItems = [];

  _NewsHomeState({this.prefs});

  final List colorList2 = [
    Colors.pink,
    Colors.pinkAccent,
    Colors.orange,
    Colors.green,
    Colors.redAccent
  ];

  String _countryIsoCodeSP = 'IN';
  Brightness _brightness;
  int color;
  String theme;
  bool _dark;
  Color colorselected;
  bool _loading;
  int _currentPage;
  int selectedIndex = 0;

  var newslist;
  var newslistCategory1,
      newslistCategory2,
      newslistCategory3,
      newslistCategory4;
  var newslistCategory5, newslistCategory6, newslistCategory7;

  TabController tabController;
  TabController tabControllerLocal;
  TabController tabControllerDownloads;
  TabController tabControllerForYou;

//Show hide Bottom and Appbar dependencies
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  bool _show = true;
  double bottomBarHeight = 56; // set bottom bar height
  double _bottomBarOffset = 0;

  void getNews() async {
    NewsApiProvider2 news = NewsApiProvider2();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  void getNewsCategory(String category, int index) async {
    NewsForCategorie newsCategory = NewsForCategorie();
    if (index == 1) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory1 = newsCategory.news;
    } else if (index == 2) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory2 = newsCategory.news;
    } else if (index == 3) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory3 = newsCategory.news;
    } else if (index == 4) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory4 = newsCategory.news;
    } else if (index == 5) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory5 = newsCategory.news;
    } else if (index == 6) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory6 = newsCategory.news;
    } else if (index == 7) {
      await newsCategory.getNewsForCategory(category);
      newslistCategory7 = newsCategory.news;
    }
    setState(() {
      _loading = false;
    });
  }

  initApp() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    List<String> _list = [];
    if (prefs.getBool('firtStart') == null) {
      setState(() {
        sharedPrefs.setStringList('liked', _list);
        sharedPrefs.setString('country', 'US');
        sharedPrefs.setBool('firtStart', false);
        sharedPrefs.setInt('color', 0xFF26A69A);
        sharedPrefs.setString('theme', 'light');
        sharedPrefs.setBool('browser', true);
      });
    } else if (sharedPrefs.getBool('firtStart') == false) {
      color = sharedPrefs.getInt('color');
      theme = sharedPrefs.getString('theme');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
    _loading = true;
    _dark = false;
    colorselected = Colors.pink;
    myScroll();
    _currentPage = 0;
    getNews();
    getNewsCategory("business", 1);
    getNewsCategory("entertainment", 2);
    getNewsCategory("general", 3);
    getNewsCategory("health", 4);
    getNewsCategory("science", 5);
    getNewsCategory("sports", 6);
    getNewsCategory("technology", 7);
    restore();
  }

  void showBottomBar() {
    setState(() {
      _show = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _show = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          showBottomBar();
        }
      }
    });
  }

//  restore() async {
//    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
//    setState(() {
//      _countryNameSP = (sharedPrefs.getString('countryName') ?? '');
//      _countryCodeSP = (sharedPrefs.getString('countryCode') ?? '91');
//      _imageURL = (sharedPrefs.getString('imageUrl') ?? '');
//      //TODO: More restoring of settings would go here...
//    });
//  }
  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      _countryIsoCodeSP = (sharedPrefs.getString('countryIsoCode') ?? 'IN');
    });
  }

  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is String) {
      sharedPrefs.setString(key, value);
    }
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  Widget bottomNavbar() {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBackgroundColor: colorselected,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        debugPrint("index===========$index");
        setState(() {
          colorselected = colorList2[index];
          selectedIndex = index;
          _currentPage = index;
        });
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.local_library,
          label: 'For You',
        ),
        FFNavigationBarItem(
          iconData: FontAwesomeIcons.globe,
          label: 'Country',
        ),
        FFNavigationBarItem(
          iconData: Icons.location_on,
          label: 'Local',
        ),
        FFNavigationBarItem(
          iconData: Icons.explore,
          label: 'Others',
        ),
        FFNavigationBarItem(
          iconData: Icons.bookmark,
          label: 'Saved',
        ),
      ],
    );
  }

  MyAppBar() {
    return _showAppbar
        ? AppBar(
            elevation: 4,
            backgroundColor: colorselected,
            title: Center(
              child: title(
                CountryPickerUtils.getCountryByIsoCode(_countryIsoCodeSP).name,
                "News",
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                          CountryPickerUtils.getFlagImageAssetPath(
                              _countryIsoCodeSP),
                          height: 20,
                          width: 35),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 25,
                      )
                    ],
                  ),
                  onTap: () {
                    _openCountryPickerDialog().then((val) => _referesh());
                  }),
            ],
            bottom: _showAppbar ? _TabBar() : _TabBar(),
          )
        : PreferredSize(
            child: Container(),
            preferredSize: Size(0.0, 0.0),
          );
  }

  TabBar _TabBar() {
    return TabBar(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 2,
      indicatorColor: Colors.white,
      isScrollable: true,
      tabs: [
        Tabs("Latest"),
        Tabs("Jobs"),
        Tabs("Education"),
        Tabs("Business"),
        Tabs("Entertainment"),
        Tabs("General"),
        Tabs("Health"),
        Tabs("Science"),
        Tabs("Sports"),
        Tabs("Technology"),
      ],
      controller: tabController,
    );
  }

  showPickerArray(BuildContext context) async {
    String country = prefs.getString('country');
    int selected = 0;
    Color textStyle = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey[800];
    Color backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]
        : Colors.white;

    if (country == 'Russia')
      selected = 0;
    else if (country == 'US')
      selected = 1;
    else if (country == 'United Kingdom')
      selected = 2;
    else if (country == 'Germany')
      selected = 3;
    else if (country == 'France') selected = 4;
    Picker(
        selecteds: [selected],
        textStyle: TextStyle(color: textStyle, fontSize: 24),
        backgroundColor: backgroundColor,
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(PickerCountry), isArray: true),
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          prefs.setString(
              'country',
              picker
                  .getSelectedValues()
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        }).showDialog(context);
  }

  MyAppBarLocal() {
    return AppBar(
      elevation: 4,
      backgroundColor: colorselected,
      title: title("Local", "HeadLines"),
      actions: <Widget>[
        GestureDetector(
            child: Row(
              children: <Widget>[
                Text("Lakhimpur"),
                Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                )
              ],
            ),
            onTap: () {
              showPickerArray(context);
            })
      ],
      bottom: TabBar(
        labelColor: colorselected,
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
          Tabs("All"),
          Tabs("Offers"),
          Tabs("Jobs"),
          Tabs("Education"),
          Tabs("Anouncement"),
          Tabs("Sports"),
          Tabs("Important"),
          Tabs("Sales"),
        ],
        controller: tabControllerLocal,
      ),
    );
  }

  MyAppBarDownloads() {
    return AppBar(
      title: title("Downloaded", "News"),
      elevation: 4,
      backgroundColor: colorselected,
      bottom: TabBar(
        labelColor: colorselected,
        labelStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        indicatorColor: Colors.red,
        isScrollable: true,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        tabs: [
          Tabs("Local"),
          Tabs("Cloud"),
          Tabs("G-Drive"),
          Tabs("Gallery"),
        ],
        controller: tabControllerDownloads,
      ),
    );
  }

  MyAppBarForYou() {
    return AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(5.0),
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 4,
          indicatorColor: Colors.blue,
          isScrollable: true,
          tabs: [Tabs("Search"), Tabs("Categories")],
          controller: tabControllerForYou,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 500; i++) {
      listItems.add('Item ${i}');
    }
    return _getMaterialApp();
  }

  Widget _getMaterialApp() {
    debugPrint("in ........._getMaterialApp");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _getScaffold(_currentPage),
    );
  }

  Widget _getScaffold(int page) {
    debugPrint("in ........._getScaffold");
    void _modalMenu() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheetMenu();
        },
      );
    }

    switch (page) {
      case 0:
        return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: MyAppBarForYou(),
                bottomNavigationBar: bottomNavbar(),
                body: _tabBarViewForYou()));
      case 1:
        return DefaultTabController(
          length: 10,
          child: new Scaffold(
            body: new NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    backgroundColor:colorselected,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      title(
                        CountryPickerUtils.getCountryByIsoCode(_countryIsoCodeSP).name,
                    "News               "),
                   GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                              CountryPickerUtils.getFlagImageAssetPath(
                                  _countryIsoCodeSP),
                              height: 20,
                              width: 35),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          )
                        ],
                      ),
                      onTap: () {
                        _openCountryPickerDialog().then((val) => _referesh());
                      })
                    ]),
                    floating: true,
                    pinned: true,
                    snap: true,
                    expandedHeight: 150,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset('assets/images/b5.jpg', fit: BoxFit.fill),
                    ),
                    bottom: _TabBar(),
                  ),
                ];
              },
              body: _tabBarView(),
            ),
            bottomNavigationBar: _show
                ? bottomNavbar()
                : Container(
                    height: _bottomBarOffset,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                  ),
          ),
        );
      case 2:
        return DefaultTabController(
            length: 8,
            child: Scaffold(
                appBar: _showAppbar
                    ? MyAppBarLocal()
                    : PreferredSize(
                        child: Container(),
                        preferredSize: Size(0.0, 0.0),
                      ),
                bottomNavigationBar: _show
                    ? bottomNavbar()
                    : Container(
                        height: _bottomBarOffset,
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                      ),
                body: _tabBarViewLocal()));
      case 3:
        return Scaffold(
            bottomNavigationBar: bottomNavbar(), body: AllHomePage());
      case 4:
        return DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: _showAppbar
                    ? MyAppBarDownloads()
                    : PreferredSize(
                        child: Container(),
                        preferredSize: Size(0.0, 0.0),
                      ),
                bottomNavigationBar: _show
                    ? bottomNavbar()
                    : Container(
                        height: _bottomBarOffset,
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                      ),
                body: _tabBarViewDownloads()));
    }
  }

  Widget _tabBarViewDownloads() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: tabControllerDownloads, children: [
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: Container(),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: CloudDownloads(),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: Container(),
      ),
      new GestureDetector(
        onTap: () {},
        child: Container(),
      ),
    ]);
  }

  Widget _tabBarViewForYou() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(controller: tabControllerDownloads, children: [
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: ForYou(),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: CloudDownloads(),
      ),
    ]);
  }

  TabBarView _tabBarView() {
    debugPrint("in ........................_tabBarView");
    return TabBarView(children: [
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslist),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),
      ListView(children: <Widget>[
        Text(" "),
        _safeAreaForCategory(newslistCategory1),
      ],),

    ]);
  }

  Widget _tabBarViewLocal() {
    debugPrint("in ........................_tabBarViewLocal");
    return TabBarView(controller: tabControllerLocal, children: [
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("lakhimpur"),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("sports"),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("education"),
      ),
      new GestureDetector(
        onTap: () {},
        child: LocalNews("education"),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("education"),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: Center(child: Container(child: Text('For Accidents & more'))),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("education"),
      ),
      new GestureDetector(
        onTap: () {
          // Change the color of the container beneath
        },
        child: LocalNews("education"),
      ),
    ]);
  }

  _safeAreaForCategory(var newslistCategoryall) {
    return SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: _scrollBottomBarController,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslistCategoryall.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl:
                                    newslistCategoryall[index].urlToImage ?? "",
                                title: newslistCategoryall[index].title ?? "",
                                desc: newslistCategoryall[index].description ??
                                    "",
                                content:
                                    newslistCategoryall[index].content ?? "",
                                posturl:
                                    newslistCategoryall[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Widget _buildDialogItem(Country country) =>Row(
    children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 12.0),
          Flexible(child: Text(country.name))
        ],
      );

  Future<void> _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text('Select your phone code'),
            onValuePicked: (Country country) {
              setState(() {
                _countryIsoCodeSP = country.isoCode;
              });
              save('countryIsoCode', country.isoCode);
            },
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('IN'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  Future<void> _referesh() {
    debugPrint("referesh is called...............................");
    getNews();
//    getNewsCategory();
    _getMaterialApp();
  }
}

const PickerCountry = '''
[
    [
        "Russia",
        "US",
        "United Kingdom",
        "Germany",
        "France"
    ]
]
    ''';
